//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Foundation

final class LoginViewModel {
    
    weak var view: LoginView?
    
    func login(_ user: String, _ password: String) {
        view?.showLoader()
    }
    
}
