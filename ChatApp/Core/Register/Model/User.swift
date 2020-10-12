//
//  User.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let contactNumber: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
