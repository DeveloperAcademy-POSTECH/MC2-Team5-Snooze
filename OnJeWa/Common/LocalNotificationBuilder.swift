//
//  LocalNotificationBuilder.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/10.
//

import Foundation
import Intents
import UIKit
import UserNotifications

//@available(iOS 15.0, *)
final class LocalNotificationBuilder {
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    private var notificationAvatarImage = ""
    private var notificationAvatarName = ""
    private var notificationContent = UNMutableNotificationContent()
    
    init(notificationAvatarImage: String, notificationAvatarName: String) {
        self.notificationAvatarImage = notificationAvatarImage
        self.notificationAvatarName = notificationAvatarName
        
        var personNameComponents = PersonNameComponents()
        
        personNameComponents.nickname = self.notificationAvatarName

        let avatar = INImage(imageData: fixOrientation(img: UIImage(named: self.notificationAvatarImage)!).pngData()!)

        let senderPerson = INPerson(
            personHandle: INPersonHandle(value: "SenderPersonHandler", type: .unknown),
            nameComponents: personNameComponents,
            displayName: self.notificationAvatarName,
            image: avatar,
            contactIdentifier: nil,
            customIdentifier: nil,
            isMe: false,
            suggestionType: .none
        )

        let mePerson = INPerson(
            personHandle: INPersonHandle(value: "MePersonHandler", type: .unknown),
            nameComponents: nil,
            displayName: nil,
            image: nil,
            contactIdentifier: nil,
            customIdentifier: nil,
            isMe: true,
            suggestionType: .none
        )

        let intent = INSendMessageIntent(
            recipients: [mePerson],
            outgoingMessageType: .outgoingMessageText,
            content: "기본 텍스트",
            speakableGroupName: INSpeakableString(spokenPhrase: self.notificationAvatarName),
            conversationIdentifier: "ConversationIdentifier",
            serviceName: nil,
            sender: senderPerson,
            attachments: nil
        )

        intent.setImage(avatar, forParameterNamed: \.sender)

        let interaction = INInteraction(intent: intent, response: nil)
        interaction.direction = .incoming
//        interaction.donate(completion: nil)

        do {
            notificationContent = try notificationContent.updating(from: intent) as! UNMutableNotificationContent
        } catch {
            print("Notification Intenting Error")
        }
        
        notificationContent.body = "기본 메시지"
        notificationContent.sound = UNNotificationSound.default
    }
    
    private func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
         
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
         
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
         
        return normalizedImage
    }
    
    func setContent(content: String) {
//        notificationContent.title = self.notificationAvatarName
        notificationContent.body = content
    }
    
    func build(secondAfter: Int) {
        let uuidString = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondAfter), repeats: false)
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: self.notificationContent,
                                            trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
        print("Notification ID \(uuidString) Completely Added.")
    }
    
    func cancelAllPendingRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("All pending notification requests canceled.")
    }
}
