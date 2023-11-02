//
//  Date+extensions.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 25/06/2023.
//

import Foundation
extension Date {
    
    func randomTime() -> Date {
        let calendar = Calendar.current
        
        let hour = Int.random(in: 0...23)
        let minute = Int.random(in: 0...59)
        let second = Int.random(in: 0...59)
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.date(from: components) ?? Date()
    }
    var getSeenTime:String! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}

