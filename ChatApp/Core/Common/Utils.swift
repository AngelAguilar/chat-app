//
//  Utils.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

final class Utils {
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
