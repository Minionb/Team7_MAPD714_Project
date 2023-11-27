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
    
    // CustomerInfo database test code
    var db = CustomerInfoDBManager()
    var custs = Array<CustomerInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabelText.textColor = .white
        passwordTextField.isSecureTextEntry = true
    }
    
    func login(cemail: String, cpassword: String) -> Bool {
        if let customer = db.getCustomer(cemail: cemail, cpassword: cpassword) {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func signinButtonOnClicked(_ sender: Any) {
        if (emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            errorLabelText.textColor = .systemRed
        }
        else {
            errorLabelText.textColor = .white
            
            let emailString = emailTextField.text ?? ""
            let passwordString = passwordTextField.text ?? ""
            
            // CustomerInfo database test code

//            custs = db.read()
//            if (emailTextField.text == custs[0].cemail && passwordTextField.text == custs[0].cpassword) {
//                let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
//                
//                present(control, animated: true)
//            }
//            else {
//                errorLabelText.textColor = .systemRed
//            }
            
            
            
            if login(cemail: emailString, cpassword: passwordString) {
                let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
                
                control.customerEmail = emailString
                
                present(control, animated: true)
            }
            else {
                errorLabelText.textColor = .systemRed
            }
            
            
            
//            let loginAlert = UIAlertController(title: "Login Successful", message: "", preferredStyle: .alert)
//            let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
//            loginAlert.addAction(continueAction)
//            self.present(loginAlert, animated: true, completion: nil)
     
            
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
//        let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
        
        present(control, animated: true)
    }
    
}
