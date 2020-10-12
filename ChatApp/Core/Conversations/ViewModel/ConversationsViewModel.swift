//
//  ConversationsViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

final class ConversationsViewModel {
    
    weak var view: ConversationsView?
    private let firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func getConversations() {
        view?.showLoader()
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }

        let safeEmail = Utils.safeEmail(emailAddress: email)

        firebaseManager.getAllConversations(for: safeEmail, completion: { [weak self] result in
            self?.view?.hideLoader()
            guard let self = self else { return }
            switch result {
            case .success(let conversations):
                guard !conversations.isEmpty else {
                    self.view?.showEmptyConversationsView()
                    return
                }
                self.view?.loadConversations(conversations: conversations)
            case .failure(_):
                self.view?.showEmptyConversationsView()
            }
        })
    }
    
    func deleteConversation(with id: String) {
        view?.showLoader()
        firebaseManager.deleteConversation(conversationId: id, completion: { [weak self] success in
            self?.view?.hideLoader()
            guard let self = self else { return }
            self.getConversations()
        })
    }
    
    func validateConversation(with email: String, name: String) {
        firebaseManager.conversationExists(with: email, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let conversationId):
                self.view?.openConversationView(email: email, id: conversationId, isNewConversation: false, name: name)
            case .failure(_):
                self.view?.openConversationView(email: email, id: nil, isNewConversation: true, name: name)
            }
        })
    }
    
}
