//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecondName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        title = "Register"
    }
    
    @IBAction func didTapRegisterBtn(_ sender: Any) {
        txtEmail.resignFirstResponder()
        txtContactNumber.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        txtSecondName.resignFirstResponder()
        viewModel?.register(txtFirstName.text!,
                            txtSecondName.text!,
                            txtEmail.text!,
                            txtContactNumber.text!,
                            txtPassword.text!)
    }
    
}

extension RegisterViewController: RegisterView {

    func showConversationsView() {
        let conversationsViewController = ConversationsComposer.composeConversations()
        navigationController?.setViewControllers([conversationsViewController], animated: true)
    }
}
