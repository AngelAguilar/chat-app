//
//  ConversationsTableViewCell.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {

    static let identifier = "ConversationTableViewCell"

    private let lblUsername: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblMessage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblUsername)
        contentView.addSubview(lblMessage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            lblUsername.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lblUsername.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            lblUsername.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lblMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lblMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            lblMessage.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 10),
        ])
    }

    public func configure(with model: Conversation) {
        lblUsername.text = model.name
        lblMessage.text = model.latestMessage.text
    }

}
