//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

final class ProfileViewModel {
    
    weak var view: ProfileView?
    private let firebaseManager: FirebaseManager
    private var user: User?
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func getUserData() {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
                return
        }
        view?.showLoader()
        let safeEmail = Utils.safeEmail(emailAddress: currentEmail)
        self.firebaseManager.getDataFor(path: safeEmail, completion: { [weak self] result in
            self?.view?.hideLoader()
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let userData = data as? [String: Any],
                    let firstName = userData["first_name"] as? String,
                    let lastName = userData["last_name"] as? String,
                    let contactNumber = userData["contact_number"] as? String else {
                        return
                }
                self.user = User(firstName: firstName, lastName: lastName, email: currentEmail, contactNumber: contactNumber)
                self.view?.loadUserData(username: currentEmail, firstName: firstName, secondName: lastName, contactNumber: contactNumber)
            case .failure(let error):
                self.view?.showErrorAlert(error: "Failed to read data with error \(error)")
            }
        })
    }
    
    func saveUserData(firstName: String, secondName: String, contactNumber: String) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            self.view?.dismissView()
            return
        }
        let user = User(firstName: firstName, lastName: secondName, email: currentEmail, contactNumber: contactNumber)

        view?.showLoader()
        firebaseManager.insertUser(with: user) { [weak self] (_) in
            self?.view?.hideLoader()
            self?.view?.dismissView()
        }
    }
    
}
