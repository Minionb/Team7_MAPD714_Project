//
//  LoginViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Cole Anam on 30/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinButtonOnClicked(_ sender: Any) {
        if (emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            errorLabel.textColor = .systemRed
        }
        else {
            errorLabel.textColor = .white
//            let loginAlert = UIAlertController(title: "Login Successful", message: "", preferredStyle: .alert)
//            let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
//            loginAlert.addAction(continueAction)
//            self.present(loginAlert, animated: true, completion: nil)
//            
            let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
            
            present(control, animated: true)
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}
