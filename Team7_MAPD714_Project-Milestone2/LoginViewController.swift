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
    
    // CustomerInfo database
    var db = CustomerInfoDBManager()
    var custs = Array<CustomerInfo>()
    var cid : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabelText.textColor = .white
        passwordTextField.isSecureTextEntry = true
    }
    
    func login(cemail: String, cpassword: String) -> Bool {
        if let customer = db.getCustomer(cemail: cemail, cpassword: cpassword) {
            cid = customer.cid
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
            
            
            if login(cemail: emailString, cpassword: passwordString) {
                let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
                
                print(cid)
                control.customerEmail = emailString
                control.cid = cid
                
                present(control, animated: true)
            }
            else {
                errorLabelText.textColor = .systemRed
            }
     
            
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}
