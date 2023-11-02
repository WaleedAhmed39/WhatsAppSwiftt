//
//  ThreadedViewModel.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import Foundation

class ThreadedViewModel:FileManageAble {
    private let recorder = VoiceRecorderManager.shared
    var messages:[Message]  = []
    var conversation:Conversations! {
        didSet {
            createRandomMessages()
        }
    }
    
    func createRandomMessages() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var messages = [Message]()
        
        let calendar = Calendar.current
        let currentDate = Date()
        
       
        
        for _ in 1...1500 {
            let text = String.randomString(Int.random(in: 0...100))
            let randomDayOffset = Int.random(in: 1...4)
            let randomHour = Int.random(in: 0...23)
            let randomMinute = Int.random(in: 0...59)
            let randomSecond = Int.random(in: 0...59)
            let randomSeen = Bool.random()
            let randomIsSent = Bool.random()
            
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            dateComponents.day! -= randomDayOffset
            dateComponents.hour = randomHour
            dateComponents.minute = randomMinute
            dateComponents.second = randomSecond
            
            if let sendingTime = calendar.date(from: dateComponents) {
                let message = Message(text: text, sendingTime: sendingTime, seen: randomSeen, deliveryStatus:DeliveryStatus.getRandomDeliveryStatus() ,isSent: randomIsSent)
                messages.append(message)
            }
        }
        
        self.messages =  messages
    }
    
    private func getConversationId() -> String {
        return conversation.buddyName
    }
    
    func startRecording() {
     
        let fileName = UUID().uuidString.appending(".m4a")
        createDirectoryIfNeeded(atFloder: getConversationId())
        guard let url = self.getFileUrl(fromfolder: getConversationId(), withkey: fileName) else {return}
        recorder.record(to: url,withId: fileName )
        recorder.currentDuration = {
            print("Cuurrent recoding Duration \($0)")
        }
        
    }
    func stopRecording() {
        recorder.stopRecording()
        print("recorded File is \(String(describing: getFileUrl(fromfolder: getConversationId(), withkey: recorder.fileName ?? "")?.absoluteString))")
    }
    func cancelRecording(){
        recorder.cancelRecording()
    }
}
