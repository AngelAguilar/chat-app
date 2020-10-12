//
//  Conversation.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
