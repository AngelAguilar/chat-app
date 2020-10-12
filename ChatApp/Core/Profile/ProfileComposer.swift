//
//  ProfileComposer.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

final class ProfileComposer {
    static func composeProfileView() -> ProfileViewController {
        let firebaseManager = FirebaseManagerImpl()
        let viewModel = ProfileViewModel(firebaseManager: firebaseManager)
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = storyboard.instantiateInitialViewController() as! ProfileViewController
        profileViewController.viewModel = viewModel
        viewModel.view = profileViewController
        return profileViewController
    }
}
