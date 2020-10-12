//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import UIKit
import MessageKit
import InputBarAccessoryView

final class ConversationViewController: MessagesViewController {

    var viewModel: ConversationViewModel?

    public let otherUserEmail: String
    private var conversationId: String?
    public var isNewConversation = false

    private var messages = [Message]()


    init(with email: String, id: String?) {
        self.conversationId = id
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }

    private func listenForMessages(id: String) {
        viewModel?.getMessages(for: id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
        if let conversationId = conversationId {
            listenForMessages(id: conversationId)
        }
    }

}

extension ConversationViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
                return
        }
        viewModel?.sendMessage(with: otherUserEmail, name: self.title ?? "User", text: text, isNewConversation: isNewConversation, conversationId: conversationId)
    }

}

extension ConversationViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        if let sender = viewModel?.selfSender {
            return sender 
        }
        fatalError("")
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .systemBlue
    }
}

extension ConversationViewController: ConversationView {
    func reloadMessages(messages: [Message]) {
        self.messages = messages

        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    func setConversationData(id: String) {
        isNewConversation = false
        let newConversationId = "conversation_\(id)"
        conversationId = newConversationId
        listenForMessages(id: newConversationId)
    }
    
    func reloadTextField() {
        messageInputBar.inputTextView.text = nil
    }
}
