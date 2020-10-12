//
//  View.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Foundation

protocol View {
    func showErrorAlert(error: String)
    func showLoader()
    func hideLoader()
}
