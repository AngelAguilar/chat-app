//
//  ProfileView.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation

protocol ProfileView: AnyObject, View {
    func loadUserData(username: String, firstName: String, secondName: String, contactNumber: String)
    func dismissView()
}
