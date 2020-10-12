//
//  NewConversationViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

final class NewConversationViewModel {
    
    let firebaseManager: FirebaseManager
    var users = [SearchResult]()
    weak var view: NewConversationView?
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func searchUser(_  query: String) {
        firebaseManager.getAllUsers(completion: { [weak self] result in
            switch result {
            case .success(let usersCollection):
                self?.filterUsers(usersCollection, with: query)
            case .failure(_):
                self?.view?.showErrorAlert(error: "No results!")
            }
        })
    }

    func filterUsers(_ users: [[String: String]], with term: String) {
        // update the UI: eitehr show results or show no results label
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }

        let safeEmail = Utils.safeEmail(emailAddress: currentUserEmail)

        let results: [SearchResult] = users.filter({
            guard let email = $0["email"], email != safeEmail else {
                return false
            }

            guard let name = $0["name"]?.lowercased() else {
                return false
            }

            return name.hasPrefix(term.lowercased())
        }).compactMap({

            guard let email = $0["email"],
                let name = $0["name"] else {
                return nil
            }

            return SearchResult(name: name, email: email)
        })
        self.view?.loadUsersResult(users: results)
    }
    
}
