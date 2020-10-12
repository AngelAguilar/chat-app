//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

final class ConversationViewModel {
    
    let firebaseManager: FirebaseManager
    weak var view: ConversationView?
    
    let dateFormatter: DateFormatter = {
        let formattre = DateFormatter()
        formattre.dateStyle = .medium
        formattre.timeStyle = .long
        formattre.locale = .current
        return formattre
    }()
    
    var selfSender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = Utils.safeEmail(emailAddress: email)

        return Sender(senderId: safeEmail,
                      displayName: "Me")
    }
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func getMessages(for id: String) {
        view?.showLoader()
        firebaseManager.getAllMessagesForConversation(with: id, completion: { [weak self] result in
            self?.view?.hideLoader()
            guard let self = self else { return }
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else {
                    return
                }
                self.view?.reloadMessages(messages: messages)
            case .failure(let error):
                self.view?.showErrorAlert(error: "Failed to get messages: \(error)")
            }
        })
    }
    
    func sendMessage(with otherUserEmail: String, name: String, text: String, isNewConversation: Bool,  conversationId: String?) {
        guard let messageId = createMessageId(with: otherUserEmail),
              let selfSender = self.selfSender else {
            return
        }
        
        print("Sending: \(text)")

        let mmessage = Message(sender: selfSender,
                               messageId: messageId,
                               sentDate: Date(),
                               kind: .text(text))
        // Send Message
        if isNewConversation {
            
            firebaseManager.createNewConversation(with: otherUserEmail, name: name, firstMessage: mmessage, completion: { [weak self] success in
                if success {
                    self?.view?.setConversationData(id: mmessage.messageId)
                    self?.view?.reloadTextField()
                }
                else {
                    self?.view?.showErrorAlert(error: "Failed to send Message")
                }
            })
        }
        else {
            guard let conversationId = conversationId else {
                return
            }

            // append to existing conversation data
            firebaseManager.sendMessage(to: conversationId, otherUserEmail: otherUserEmail, name: name, newMessage: mmessage, completion: { [weak self] success in
                if success {
                    self?.view?.reloadTextField()
                }
                else {
                    self?.view?.showErrorAlert(error: "Failed to send message.")
                }
            })
        }
    }
    
    private func createMessageId(with: String) -> String? {
        // date, otherUesrEmail, senderEmail, randomInt
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }

        let safeCurrentEmail = Utils.safeEmail(emailAddress: currentUserEmail)

        let dateString = dateFormatter.string(from: Date())
        let newIdentifier = "\(with)_\(safeCurrentEmail)_\(dateString)"

        print("created message id: \(newIdentifier)")

        return newIdentifier
    }
    
}
