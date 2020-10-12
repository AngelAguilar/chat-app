//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecondName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    
    var viewModel: ProfileViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getUserData()
    }
    
    @IBAction func didTapBtnSave(_ sender: Any) {
        viewModel?.saveUserData(firstName: txtFirstName.text!, secondName: txtSecondName.text!, contactNumber: txtContactNumber.text!)
    }
    
}

extension ProfileViewController: ProfileView {
    func loadUserData(username: String,
                      firstName: String,
                      secondName: String,
                      contactNumber: String) {
        lblUsername.text = username
        txtFirstName.text = firstName
        txtSecondName.text = secondName
        txtContactNumber.text = contactNumber
    }
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
