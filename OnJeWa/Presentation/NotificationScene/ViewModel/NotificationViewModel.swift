//
//  NotificationViewModel.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import Foundation
import UIKit

// MARK: - Model

enum NotificationType {
    case chat
    case mission
    case invitation
}

struct Notification {
    let notificationType: NotificationType
    let profile: String
    let content: String
    let time: String
    let image: String?
}

let menus: [Notification] = [
    Notification(notificationType: .invitation, profile: "IMG_2", content: "지연", time: "14:00", image: nil),
    Notification(notificationType: .mission, profile: "IMG_9", content: "현주", time: "16:00", image: "IMG_2"),
    Notification(notificationType: .chat, profile: "IMG_8", content: "안녕! 주인 오늘 날씨가 완젼 죠아.\n이따 산책 어때?", time: "19:00", image: nil),
    Notification(notificationType: .invitation, profile: "IMG_2", content: "지연", time: "14:00", image: nil),
    Notification(notificationType: .mission, profile: "IMG_9", content: "현주", time: "16:00", image: "IMG_2"),
    Notification(notificationType: .chat, profile: "IMG_8", content: "밥 머것어? 나는 벌써 주이니가 보고시포ㅠㅜ\n8시간이나 지나따", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "주이니!! 온제 들오와!\n저녁 같이 먹쟈아ㅏ 마싯는 간식 부타캐오", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
    Notification(notificationType: .chat, profile: "IMG_8", content: "ㅋㅋㅋㅋ 주인아 답장 안하냐\n두 줄로 말하게 만들지 마ㅋㅋ", time: "19:00", image: nil),
]
