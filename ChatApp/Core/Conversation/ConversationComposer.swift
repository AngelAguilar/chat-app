//
//  ConversationComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//


import Foundation
import UIKit

final class ConversationComposer {
    static func composeConversation(with email: String, id: String?) -> ConversationViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = ConversationViewModel(firebaseManager: firebaseManager)
        let conversationViewController = ConversationViewController(with: email, id: id)
        conversationViewController.viewModel = viewModel
        viewModel.view = conversationViewController
        return conversationViewController
    }
}
