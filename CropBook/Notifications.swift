//
//  Notifications.swift
//  CropBook
//
//  Created by jon on 2018-06-30.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject {
    
    
    func Schedule() {
        //iOS 10 or above version
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Watering Time!"
        content.body = "Time to water your crops!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default()
        
        // Set specific time and data here
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: Date())
        print(Calendar.current.component(.hour, from: Date()))
        let b = Calendar.current.component(.minute, from: Date())
        dateComponents.minute = b
        print(Calendar.current.component(.minute, from: Date()))
        
        // Set trigger for specfic time and date
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // Sets trigger for 5 seconds for test
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Make Request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    func RequestPermission(){
        print("Verifying Permission")
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
        if !granted {
            print("Permission Refused")
            }
        }
    }

}

