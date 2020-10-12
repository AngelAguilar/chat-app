//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Foundation
import FirebaseAuth

final class LoginViewModel {
    
    weak var view: LoginView?
    private let firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func login(_ email: String, _ password: String) {
        
        guard  !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            view?.showErrorAlert(error: "Please complete all information to log in.")
            return
        }
        
        view?.showLoader()
        // Firebase Log In
        FirebaseAuth.Auth.auth().signIn(withEmail: email,
                                        password: password,
                                        completion: { [weak self] authResult, error in
            guard let self = self else {
                return
            }

            self.view?.hideLoader()

            guard let result = authResult, error == nil else {
                self.view?.showErrorAlert(error: "Failed to log in user with email: \(email)")
                return
            }

            let user = result.user

            let safeEmail = Utils.safeEmail(emailAddress: email)
            self.firebaseManager.getDataFor(path: safeEmail, completion: { result in
                switch result {
                case .success(let data):
                    guard let userData = data as? [String: Any],
                        let firstName = userData["first_name"] as? String,
                        let lastName = userData["last_name"] as? String else {
                            return
                    }
                    UserDefaults.standard.set("\(firstName) \(lastName)", forKey: "name")
                    
                case .failure(let error):
                    print("Failed to read data with error \(error)")
                }
            })

            UserDefaults.standard.set(user.email ?? "", forKey: "email")

            print("Logged In User: \(user)")
            self.view?.showContactsView()
        })
    }
    
}
