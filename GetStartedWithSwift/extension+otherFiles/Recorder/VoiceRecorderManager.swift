//
//  VoiceRecorderManager.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import Foundation
import AVFAudio

class VoiceRecorderManager: NSObject {
    
    //MARK:- Instance
    static let shared = VoiceRecorderManager()
    
    //MARK:- Variables ( Private )
    private var audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    private var audioRecorder : AVAudioRecorder!
    private var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    private var settings =   [  AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                              AVSampleRateKey: 44100,
                        AVNumberOfChannelsKey: 2,
                     AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue ]
    
    fileprivate var timer: Timer!
    private var myRecordings = [String]()
    var fileName : String?
    var fileMessageId : String?
    public var currentDuration : ((String)->Void)?
    public var currentTimeLap : ((Double)->Void)?
    public var currentPlayingStatus : ((_ isplaying:Bool)->Void)?
    public var errorWhilePlaying : ((_ isplaying:Bool)->Void)?
    //MARK:- Public Variables
    /// Can be changed by user
    var isRecording : Bool = false
    var isPlaying : Bool = false
    var duration = CGFloat()
    var recordingName : String?
    var numberOfLoops : Int?
    
    
    //MARK:- Set Rate Limits
    var rate : Float?{
        didSet{
            if (rate! < 0.5) {
                rate = 0.5
                print("Rate cannot be less than 0.5")
            } else if (rate! > 2.0) {
                rate = 2.0
                print("Rate cannot exceed 2")
            }
        }
    }
    
    
    //MARK:- Pre - Recording Setup
    private func InitialSetup(to path : URL){

        
        do{ /// Setup audio player
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            audioRecorder = try AVAudioRecorder(url: path, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioPlayer.stop()
        } catch let audioError as NSError {
            print ("Error setting up: %@", audioError)
        }
    }
    
    
    //MARK:- Record
    func record(to path : URL,withId id: String){
        checkForPermission{[self] in
            if $0 {
                fileName = id
                fileMessageId = id
                // fileMessageId = filename
                InitialSetup(to: path)
                if let audioRecorder = audioRecorder{
                    if !isRecording {
                        do{
                            try audioSession.setActive(true)
                            duration = 0
                            isRecording = true
                            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateDuration), userInfo: nil, repeats: true) /// start  timer
                            audioRecorder.record() /// start recording
                            debugLog("Recording")
                        } catch let recordingError as NSError{
                            print ("Error recording : %@", recordingError.localizedDescription)
                        }
                    }
                }
            }
        }
        
    }
    
    
    //MARK:- Stop Recording
    func stopRecording(completion: (() -> Void)? = nil){
        if audioRecorder != nil{
            audioRecorder.stop() /// stop recording
            audioRecorder = nil
            do {
                try audioSession.setActive(false)
                isRecording = false
                debugLog("Recording Stopped")
            } catch {
                print("stop()",error.localizedDescription)
            }
        }
    }
    //MARK:- Cancel Recording
    func cancelRecording(){
        if audioRecorder != nil{
            audioRecorder.stop() /// stop recording
            audioRecorder = nil
            recordingName = nil
            numberOfLoops = nil
            do {
                try audioSession.setActive(false)
                isRecording = false
                debugLog("Recording Stopped")
            } catch {
                print("stop()",error.localizedDescription)
            }
        }
    }
    
    //MARK:- Play recording
    func play(completion: @escaping (Bool) -> ()){
        if !isRecording && !isPlaying {
            if let fileName = fileName {
                let path = getDocumentsDirectory().appendingPathComponent(fileName+".m4a")
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: path)
                    (rate == nil) ? (audioPlayer.enableRate = false) : (audioPlayer.enableRate = true)
                    audioPlayer.rate = rate ?? 1.0   /// set rate
                    audioPlayer.delegate = self
                    audioPlayer.numberOfLoops = numberOfLoops ?? 0   /// set numberofloops
                    audioPlayer.play()   /// play
                    isPlaying = true
                    debugLog("Playing")
                    completion(true)
                }catch{
                    print(error.localizedDescription)
                }}else{
                    completion(false)
                    print("no file exists")
                }
        }else{
            completion(false)
            return
        }
    }
    
    func seekPlayer(to:Double){
        if isPlaying {
            audioPlayer.currentTime = to
        }
        
    }
    //MARK:- Play by name
    func play(name:String) {
        var fileName = name
        if !name.contains(".m4a") {
            fileName = name + ".m4a"
        }
        
        
        let path = getDocumentsDirectory().appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: path.path) && !isRecording && !isPlaying {
            audioPlayer.prepareToPlay()
            do {
                
                audioPlayer = try AVAudioPlayer(contentsOf: path)
                audioPlayer.delegate = self
                audioPlayer.play()  /// play
                isPlaying = true
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimeLap), userInfo: nil, repeats: true)
                debugLog("Playing")
                currentPlayingStatus?(true)
                self.fileName = fileName
            } catch {
                errorWhilePlaying?(false)
                print("play(with name:), ",error.localizedDescription)
            }
        } else {
            errorWhilePlaying?(false)
            print("File Does not Exist")
            return
        }
    }
    
    
    //MARK:- Stop Playing
    func stopPlaying(){
        audioPlayer.stop()   ///stop
        isPlaying = false
        currentPlayingStatus?(isPlaying)
        debugLog("Stopped playing")
    }
    
    
    //MARK:- Delete Recording
    func deleteRecording(name: String){
        let path = getDocumentsDirectory().appendingPathComponent(name.appending(".m4a"))
        let manager = FileManager.default
        
        if manager.fileExists(atPath: path.path) {
            
            do {
                try manager.removeItem(at: path)
                removeRecordingFromArray(name: name)
                debugLog("Recording Deleted")
            } catch {
                print("delete()",error.localizedDescription)
            }
        } else {
            print("File is not exist.")
        }
    }
    
    
    //MARK:- remove recroding name instance
    private func removeRecordingFromArray(name: String){
        if myRecordings.contains(name){
            let index = myRecordings.firstIndex(of: name)
            myRecordings.remove(at: index!)
        }
    }
    
    
    //MARK:- Restart
    func restartPlayer(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.play()
        isPlaying = true
    }
    
    
    //MARK:- Get duration of recording
    func getDuration() -> String {
        return duration.timeStringFormatter
    }
    
    
    //MARK:- Live time
    func getCurrentTime() -> Double {
        return audioPlayer.currentTime
    }
    func getFormatedCurrentTime() -> String {
        return CGFloat(audioPlayer.currentTime).timeStringFormatter
    }
    
    //MARK:- Check for overwritten files
    private func checkRepeat(name: String) -> Bool{
        var count = 0
        if myRecordings.contains(name){
            count = myRecordings.filter{$0 == name}.count
            if count > 1{
                while count != 1{
                    let index = myRecordings.firstIndex(of: name)
                    myRecordings.remove(at: index!)
                    count -= 1
                }
                return false
            }
        }
        return true
    }
    
    
    //MARK:- Track time
    @objc func updateDuration() {
        if isRecording && !isPlaying{
            duration += 1
            currentTimeLap?(audioPlayer.currentTime)
            currentDuration?(self.getDuration())
        }else{
            timer.invalidate()
        }
    }
    //MARK:- Track time for Playinh
    @objc func updateTimeLap() {
        if isPlaying {
            duration += 1
            currentTimeLap?(audioPlayer.currentTime)
            currentDuration?(self.getFormatedCurrentTime())
        }else{
            timer.invalidate()
        }
    }
    //MARK:- Get path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


//MARK:- AVAudioRecorder Delegate functions
extension VoiceRecorderManager : AVAudioRecorderDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        isRecording = false
        timer.invalidate()
        
        switch flag {
        case true:
            debugLog("record finish")
        case false:
            debugLog("record erorr")
        }
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        isRecording = false
        debugLog(error?.localizedDescription ?? "Error occured while encoding recorder")
    }
}


//MARK:- AVAudioPlayer Delegate functions
extension VoiceRecorderManager: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        currentPlayingStatus?(isPlaying)
        debugLog("playing finish")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        isPlaying = false
        debugLog(error?.localizedDescription ?? "Error occured while encoding player")
    }
}


//MARK:- Convert Time to String
extension CGFloat{
    var timeStringFormatter : String {
        let format : String?
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        if minutes < 60 {    format = "%01i:%02i"   }
        else {    format = "%01i:%02i"    }
        return String(format: format!, minutes, seconds)
    }
}


//MARK:- Computed property to get list of recordings
extension VoiceRecorderManager{
    var getRecordings : [String]{
        return self.myRecordings
    }
}
private extension VoiceRecorderManager {
    func checkForPermission (result:@escaping ((Bool)->())) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            result(true)
        case .denied:
            result(false)
        case .undetermined:
            // print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                result(true)
            })
        @unknown default:
            result(false)
            // print("Unknown case")
        }
    }
}




//MARK:- Easy debugging
public func debugLog(_ message: String) {
#if DEBUG
    print("=================================================")
    print(message)
    print("=================================================")
#endif
}
