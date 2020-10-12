//
//  NewConversationComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

final class NewConversationsComposer {
    static func composeNewConversationView(delegate: NewConversationViewControllerDelegate?) -> NewConversationViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = NewConversationViewModel(firebaseManager: firebaseManager)
        let newConversationViewController = NewConversationViewController()
        newConversationViewController.viewModel = viewModel
        viewModel.view = newConversationViewController
        newConversationViewController.delegate = delegate
        return newConversationViewController
    }
}
