//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

class ConversationsViewController: UIViewController, View {
    
    var viewModel: ConversationsViewModel?
    private var conversations = [Conversation]()
 
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversations!"
        label.textAlignment = .center
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        viewModel?.getConversations()
    }
    
    private func initViews() {
        title = "Conversations"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noConversationsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noConversationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    
    @objc private func didTapComposeButton() {
        let newConversationView = NewConversationsComposer.composeNewConversationView(delegate: self)
        let navVC = UINavigationController(rootViewController: newConversationView)
        present(navVC, animated: true)
    }
    
    @objc private func didTapEditButton() {
        let profileView = ProfileComposer.composeProfileView()
        let navVC = UINavigationController(rootViewController: profileView)
        present(navVC, animated: true)
    }

    
}

extension ConversationsViewController: ConversationsView {
    func showEmptyConversationsView() {
        tableView.isHidden = true
        noConversationsLabel.isHidden = false
    }
    
    func loadConversations(conversations: [Conversation]) {
        noConversationsLabel.isHidden = true
        tableView.isHidden = false
        self.conversations = conversations
        tableView.reloadData()
    }
    
    func openConversationView(email: String, id: String?, isNewConversation: Bool, name: String) {
        let conversationVuewController = ConversationComposer.composeConversation(with: email, id: id)
        conversationVuewController.isNewConversation = isNewConversation
        conversationVuewController.title = name
        conversationVuewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(conversationVuewController, animated: true)
    }
}

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = conversations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.identifier, for: indexPath) as! ConversationTableViewCell
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = conversations[indexPath.row]
        openConversation(model)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteConversation(with: conversations[indexPath.row].id)
        }
    }
}

extension ConversationsViewController: NewConversationViewControllerDelegate {
    
    func selectedUser(user: SearchResult) {
        let currentConversations = self.conversations

        if let conversation = currentConversations.first(where: {
            $0.otherUserEmail == Utils.safeEmail(emailAddress: user.email)
        }) {
            self.openExistingConversation(conversation: conversation)
        }
        else {
            self.createNewConversation(result: user)
        }
    }
    
    private func openExistingConversation(conversation: Conversation) {
        let conversationViewController = ConversationComposer.composeConversation(with: conversation.otherUserEmail, id: conversation.id)
        conversationViewController.isNewConversation = false
        conversationViewController.title = conversation.name
        conversationViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
    
    private func createNewConversation(result: SearchResult) {
        let name = result.name
        let email = Utils.safeEmail(emailAddress: result.email)
        viewModel?.validateConversation(with: email, name: name)
    }
    
    
    func openConversation(_ model: Conversation) {
        let conversationViewController = ConversationComposer.composeConversation(with: model.otherUserEmail, id: model.id)
        conversationViewController.title = model.name
        conversationViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
}
