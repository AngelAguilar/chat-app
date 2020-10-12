//
//  ConversationView.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

protocol ConversationView: AnyObject, View {
    func reloadMessages(messages: [Message])
    func setConversationData(id: String)
    func reloadTextField()
}
