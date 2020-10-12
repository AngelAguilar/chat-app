//
//  ResetPasswordComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

final class ResetPasswordComposer {
    static func composeResetPassword() -> ResetPasswordViewController {
        let viewModel = ResetPasswordViewModel()
        let storyboard = UIStoryboard(name: "ResetPassword", bundle: nil)
        let resetPasswordViewController = storyboard.instantiateInitialViewController() as! ResetPasswordViewController
        resetPasswordViewController.viewModel = viewModel
        viewModel.view = resetPasswordViewController
        return resetPasswordViewController
    }
}
