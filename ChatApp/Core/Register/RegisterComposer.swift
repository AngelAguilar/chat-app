//
//  RegisterComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

final class RegisterComposer {
    static func composeLogin() -> RegisterViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = RegisterViewModel(firebaseManager: firebaseManager)
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let registerViewController = storyboard.instantiateInitialViewController() as! RegisterViewController
        registerViewController.viewModel = viewModel
        viewModel.view = registerViewController
        return registerViewController
    }
}
