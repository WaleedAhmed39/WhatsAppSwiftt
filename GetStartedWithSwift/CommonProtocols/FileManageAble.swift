//
//  FileManageAble.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import Foundation
import UIKit
import AVFoundation
protocol FileManageAble {
func saveFileData(tofolder folder : String,withkey key : String, andActual data : Data)->String?
    func getFileData(fromfolder folder : String, withkey key :String)->Data?
    func  getUrl(fromfolder folder : String, withkey key :String)->String?
    func getFileUrl(fromfolder folder : String, withkey key :String)->URL? 
    func getFileSizeInByte(fromPath path : String)->Int64?
    func getFormattedFileSize(from path : String)->String?
//    func getFileType(fromName name  : String?, withMimeType type : String?)
}
extension FileManageAble {
 @discardableResult func   saveFileData(tofolder folder : String,withkey key : String, andActual data : Data)->String? {
    
    guard let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil}
    
    var fileURL = docDirectory.appendingPathComponent("\(folder)")
    if  !FileManager.default.fileExists(atPath: fileURL.path) {
           try? FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
        }
       do {
        fileURL = fileURL.appendingPathComponent(key)
        try data.write(to: fileURL)
        
       } catch let error {
           print("error saving file with error", error)
       }
    
    return fileURL.absoluteString;
    }
    @discardableResult func saveToAlbum(data : Data)->Bool {
        guard let image = UIImage(data: data) else {
            return false
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return true
    }
    @discardableResult func getFileData(fromfolder folder : String, withkey key :String)->Data? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return try?  Data.init(contentsOf: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(folder).appendingPathComponent(key).absoluteURL)
          
            }
            return nil
    }
    @discardableResult func getUrlMetaData(fromfolder folder : String, withkey key :String)->Data? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return try?  Data.init(contentsOf: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(folder).appendingPathComponent(key).absoluteURL)
          
            }
            return nil
    }
    @discardableResult func getFileData(fromPath path : String)->Data? {
        if let url =  URL(string: path) {
            return try? Data(contentsOf: url)
        }
            return nil
    }
    @discardableResult func getUrl(fromfolder folder : String, withkey key :String)->String? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(folder).appendingPathComponent(key).absoluteString
          
            }
            return nil
    }
    @discardableResult func getFileUrl(fromfolder folder : String, withkey key :String)->URL? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(folder).appendingPathComponent(key)
          
            }
            return nil
    }
    @discardableResult  func getFileSizeInByte(fromPath path : String)-> Int64? {
        guard  let attr = try? FileManager.default.attributesOfItem(atPath: path) else {
            
            return nil
        }
       // let attr = try! FileManager.default.attributesOfItem(atPath: path)
       return attr[FileAttributeKey.size] as? Int64

    
    }
    @discardableResult func  getFormattedFileSize(from path : String)->String?{
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        if let byte = getFileSizeInByte(fromPath: path) {
            return bcf.string(fromByteCount: byte)
        }
        return nil
    }
      func createDirectoryIfNeeded(atFloder folder : String){
        
        guard let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
        
        let fileURL = docDirectory.appendingPathComponent("\(folder)")
        if  !FileManager.default.fileExists(atPath: fileURL.path) {
               try? FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
            }
    }
      func createThumbnailOfVideoFromFileURL(videoURL: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: videoURL)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(Float64(1), preferredTimescale: 100)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return UIImage(named: "ico_placeholder")
        }
    }
}

