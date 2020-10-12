//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    
    weak var view: RegisterView?
    let firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func register(_ firstName: String,
                  _ lastName: String,
                  _ email: String,
                  _ contactNumber: String,
                  _ password: String) {
        self.view?.showLoader()

        firebaseManager.userExists(with: email, completion: { [weak self] exists in
            guard let self = self else {
                return
            }

            guard !exists else {
                // user already exists
                self.view?.hideLoader()
                self.view?.showErrorAlert(error: "Looks like a user account for that email address already exists.")
                return
            }

            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                guard error == nil else {
                    self.view?.hideLoader()
                    self.view?.showErrorAlert(error:"Error creating user")
                    return
                }

                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue("\(firstName) \(lastName)", forKey: "name")

                let user = User(firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                          contactNumber: contactNumber)
                self.firebaseManager.insertUser(with: user, completion: { success in
                    self.view?.hideLoader()
                    if success {
                        self.view?.showConversationsView()
                    } else {
                        self.view?.showErrorAlert(error: "There was an error creating the user")
                    }
                })

            })
        })
    }
    
}
