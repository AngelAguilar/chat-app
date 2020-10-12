//
//  ResetPasswordViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import FirebaseAuth

final class ResetPasswordViewModel {
    
    weak var view: ResetPasswordView?
    
    func resetPasword(_ email: String) {
        view?.showLoader()
        guard !email.isEmpty else {
            view?.hideLoader()
            view?.showErrorAlert(error: "Please provide your email")
            return
        }
        
        FirebaseAuth.Auth.auth().sendPasswordReset(withEmail: email) { [weak self] (error) in
            self?.view?.hideLoader()
            guard let self = self else { return }
            if error != nil {
                self.view?.showErrorAlert(error: "An error occurred, please try again later.")
            } else {
                self.view?.showLogin()
            }
        }
    }
}
