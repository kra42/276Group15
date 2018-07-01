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
    
    var hour : Int = 0;
    var minute : Int = 0;
    // Weekdays are Sunday=1 ... Saturday=7
    var weekDay : Int = 1;
    
    
    func setHour(Hour : Int) {
        self.hour = Hour
    }
    
    func setMinute(Minute : Int) {
        self.minute = Minute
    }
    
    func setWeekDay(Day:Int){
        self.weekDay = Day
    }
    
    func Schedule() {
        //iOS 10 or above
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Watering Time!"
        content.body = "Time to water your crops!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default()
        
        // Set specific time and data here
        var dateComponents = DateComponents()
        dateComponents.hour = self.hour
        dateComponents.minute = self.minute
        dateComponents.weekday = self.weekDay
        // Initialise trigger for specfic time and date
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Sets trigger for 5 seconds to test
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Make Request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // Schedule Request
        center.add(request)
    }
    
    func RequestPermission(){
        print("Verifying Notification Permission")
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

