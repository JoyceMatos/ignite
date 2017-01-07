//
//  Notification.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/6/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UserNotifications

class DailyNotification {
    
    class func scheduleLocal(on date: Date) {
        
        let center = UNUserNotificationCenter.current()
        
        
        let hourComponent = Calendar.current.component(.hour, from: date)
        let minuteComponent = Calendar.current.component(.day, from: date)
        
        print("scheduled hour: \(hourComponent)")
        print("scheduled minute: \(minuteComponent)")
        
        
        var dateComponents = DateComponents()
        // 3:11 PM everyday
        dateComponents.hour = hourComponent
        dateComponents.minute = minuteComponent
        
        print("dateComponent: \(dateComponents.hour)")
        print("dateComponent: \(dateComponents.minute)")

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // Test Request
      //    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(hourComponent), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Motivate"
        content.body = "Your Quote Of The Day is Ready"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.removeAllPendingNotificationRequests()
        center.add(request)
        
        //cancel pending notifications – i.e., notifications you have scheduled that have yet to be delivered because their trigger hasn’t been met
        //     center.removeAllPendingNotificationRequests()
        
        
    }
}
