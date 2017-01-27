//
//  Notification.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/6/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit


class DailyNotification: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Delegate method
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
                
            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")
                break
                
            default:
                break
            }
        }
        
        // you must call the completion handler when you're done
        completionHandler()
    }
    
    
     func scheduleLocal(on date: Date) {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
        
//        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
//        let hour = dateComponents.hour ?? 9999
//        let minute = dateComponents.minute ?? 11
        
        let test = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        print(test.hour ?? "OK")
        print(test.minute)

        let trigger = UNCalendarNotificationTrigger(dateMatching: test, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "Your quote of the day is ready!"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()

        
       // center.removeAllPendingNotificationRequests()
        
        
        let request = UNNotificationRequest(identifier: "MyTrigger", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("UNABLE TO ADD .... \(error.localizedDescription)")
                // Do something with error
            } else {
                print("WERE IN!!!!")
                // Request was added successfully
            }
        }
        
    }
    
   
}
