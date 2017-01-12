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

        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 25
        let trigger = UNCalendarNotificationTrigger(dateMatching: test, repeats: true)
        
        
        
        
        
        
        //var dateComponents = DateComponents()
        // 3:11 PM everyday
        
        // Hard Coded Components
        //dateComponents.hour = 6 //hourComponent
       // dateComponents.minute = 33 //minuteComponent
     //   dateComponents.timeZone
        
        
   

       // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
       // let realTrigger = UNTimeIntervalNotificationTrigger(timeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>)
        
        // Test Request
    //      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(hourComponent), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Motivate"
        content.body = "Your Quote Of The Day is Ready"
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
        
        
        //cancel pending notifications – i.e., notifications you have scheduled that have yet to be delivered because their trigger hasn’t been met
        //     center.removeAllPendingNotificationRequests()
        
        
    }
    
   
}
