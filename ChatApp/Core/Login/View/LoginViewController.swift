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
    weak var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    
    private func initViews() {
        title = "Chat Application"
    }
    
    @IBAction func didTapBtnLogin(_ sender: Any) {
    }
    
    @IBAction func didTapBtnRegister(_ sender: Any) {
    }
    
    @IBAction func didTapBtnPassword(_ sender: Any) {
    }
    
}

extension LoginViewController: LoginView {
    
    func showErrorAlert(error: String) {
        
    }
    
    func showContactsView() {
        
    }
}

