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
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateInitialViewController() as! LoginViewController
        let viewModel = LoginViewModel()
        viewModel.view = loginViewController
        loginViewController.viewModel = viewModel
        return loginViewController
    }
}
