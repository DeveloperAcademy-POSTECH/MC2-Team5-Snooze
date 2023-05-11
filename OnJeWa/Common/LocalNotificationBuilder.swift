//
//  LocalNotificationBuilder.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/10.
//

import Foundation
import UserNotifications

class LocalNotificationBuilder {
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    private var notificationContent = UNMutableNotificationContent()
    
    func setContent(title: String, content: String) -> LocalNotificationBuilder {
        notificationContent.title = title
        notificationContent.body = content
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = 1
        
        return self
    }
    
    func build(secondAfter: Int) {
        let uuidString = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondAfter), repeats: false)
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}

// MARK: how to use notification

//LocalNotificationBuilder()
//    .setContent()
//    .build()
