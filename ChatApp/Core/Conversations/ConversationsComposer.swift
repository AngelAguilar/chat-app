//
//  ContactsComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

final class ConversationsComposer {
    static func composeConversations() -> ConversationsViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = ConversationsViewModel(firebaseManager: firebaseManager)
        let storyboard = UIStoryboard(name: "Conversations", bundle: nil)
        let conversationsController = storyboard.instantiateInitialViewController() as! ConversationsViewController
        conversationsController.viewModel = viewModel
        viewModel.view = conversationsController
        return conversationsController
    }
}
