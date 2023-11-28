//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 10/30/2023
//  Description: Register Screen

import UIKit
import SQLite3

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    
    // CustomerInfo database test code
    var db = CustomerInfoDBManager()
    var custs = Array<CustomerInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextLabel.textColor = .white
        
        //db.deleteAllCustomers()
        custs = db.read()
    }
    
    @IBAction func signUpButtonOnClicked(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty == true || lastNameTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || ageTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true ||
            cityTextField.text?.isEmpty == true ||
            countryTextField.text?.isEmpty == true ||
            telephoneTextField.text?.isEmpty == true) {
            errorTextLabel.textColor = .systemRed
        }
        else {
            errorTextLabel.textColor = .white
            
            
            // CustomerInfo database test code
            let cfirstname = firstNameTextField.text!
            let clastname = lastNameTextField.text!
            let cemail = emailTextField.text!
            let cpassword = passwordTextField.text!
            guard let cage = Int(ageTextField.text!) else { return }
            let caddress = addressTextField.text!
            let ccity = cityTextField.text!
            let ccountry = countryTextField.text!
            let ctelephone = telephoneTextField.text!

            if let isExistedCustomer = db.getCustomerByEmail(cemail: cemail)
            {
                let userExistStatement = "User with " + cemail + " is already registered. Please log in or register with another email address."
                // Create the alert controller
                let alertController = UIAlertController(title: "User Exists!", message: userExistStatement, preferredStyle: .alert)

                // Create an action for the alert
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                }

                // Add the action to the alert controller
                alertController.addAction(okAction)

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
            }
            else{
                db.insert(cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: cage, caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone)
                
                let successStatement = "You have successfully registered with " + cemail + ". Please login and book your favorable cruises!"
                // Create the alert controller
                let alertController = UIAlertController(title: "Successfully Registered!", message: successStatement, preferredStyle: .alert)

                // Create an action for the alert
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                }

                // Add the action to the alert controller
                alertController.addAction(okAction)

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
                
                firstNameTextField.text = ""
                lastNameTextField.text = ""
                emailTextField.text = ""
                passwordTextField.text = ""
                ageTextField.text = ""
                addressTextField.text = ""
                cityTextField.text = ""
                countryTextField.text = ""
                telephoneTextField.text = ""
            }
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}
