//
//  ConversationsView.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

protocol ConversationsView: AnyObject, View {
    func showEmptyConversationsView()
    func loadConversations(conversations: [Conversation])
    func openConversationView(email: String, id: String?, isNewConversation: Bool, name: String)
}
