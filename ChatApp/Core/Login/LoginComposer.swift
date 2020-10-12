//
//  LoginComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Foundation
import UIKit

final class LoginComposer {
    static func composeLogin() -> LoginViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = LoginViewModel(firebaseManager: firebaseManager)
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateInitialViewController() as! LoginViewController
        loginViewController.viewModel = viewModel
        viewModel.view = loginViewController
        return loginViewController
    }
}
