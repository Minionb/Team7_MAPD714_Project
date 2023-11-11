//
//  LoginViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 10/30/2023
//  Description: Login Screen

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabelText.textColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinButtonOnClicked(_ sender: Any) {
        if (emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            errorLabelText.textColor = .systemRed
        }
        else {
            errorLabelText.textColor = .white
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
