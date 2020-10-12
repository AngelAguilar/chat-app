//
//  NewConversationView.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

protocol NewConversationView: AnyObject, View {
    func loadUsersResult(users: [SearchResult])
}
