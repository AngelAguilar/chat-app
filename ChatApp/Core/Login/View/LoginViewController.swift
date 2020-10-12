//
//  ViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    
    private func initViews() {
        title = "Login"
    }
    
    @IBAction func didTapBtnLogin(_ sender: Any) {
        viewModel?.login(txtUsername.text!, txtPassword.text!)
    }
    
    @IBAction func didTapBtnRegister(_ sender: Any) {
        let registerViewController = RegisterComposer.composeLogin()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @IBAction func didTapBtnPassword(_ sender: Any) {
        let resetPasswordViewController = ResetPasswordComposer.composeResetPassword()
        navigationController?.pushViewController(resetPasswordViewController, animated: true)
    }
    
}

extension LoginViewController: LoginView {

    func showContactsView() {
        let contactsViewController = ConversationsComposer.composeConversations()
        navigationController?.setViewControllers([contactsViewController], animated: true)
    }
}

