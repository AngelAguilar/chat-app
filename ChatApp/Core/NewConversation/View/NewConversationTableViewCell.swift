//
//  NewConversationTableViewCell.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import UIKit

class NewConversationCell: UITableViewCell {

    static let identifier = "NewConversationCell"

    private let labelUserName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    private func initViews() {
        contentView.addSubview(labelUserName)
        NSLayoutConstraint.activate([
            labelUserName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelUserName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            labelUserName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelUserName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        
    }

    public func configure(with model: SearchResult) {
        labelUserName.text = model.name
    }

}
