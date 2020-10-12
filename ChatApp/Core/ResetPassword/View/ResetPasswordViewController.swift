//
//  ResetPasswordViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import Foundation
import UIKit

class ResetPasswordViewController: UIViewController {
    
    var viewModel: ResetPasswordViewModel?
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        title = "Reset Password"
    }
    @IBAction func didtapResetpasswordBtn(_ sender: Any) {
        viewModel?.resetPasword(txtEmail.text!)
    }
}

extension ResetPasswordViewController: ResetPasswordView {
    func showLogin() {
        let alertViewController = UIAlertController(title: "Success!", message: "We have e-mailed your password reset link ", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alertViewController, animated: true, completion: nil)
    }
}
