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
    
    class func scheduleLocal() {
        
        let center = UNUserNotificationCenter.current()
        
        var dateComponents = DateComponents()
        // 3:11 PM everyday
        dateComponents.hour = 15
        dateComponents.minute = 11
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // Test Request
        //  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Motivate"
        content.body = "Your Quote Of The Day is Rady"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
        //cancel pending notifications – i.e., notifications you have scheduled that have yet to be delivered because their trigger hasn’t been met
        //     center.removeAllPendingNotificationRequests()
        
        
    }
}
