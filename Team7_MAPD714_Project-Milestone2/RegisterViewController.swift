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
        
        // CustomerInfo database test code
        db.insert(cid: 1, cfirstname: "Cole", clastname: "Anam", cemail: "coleanam@gmail.com", cpassword: "admin", cage: 23, caddress: "temp", ccity: "Toronto", ccountry: "Canada", ctelephone: "123-456-7890")
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
            db.insert(cid: 2, cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: cage, caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone)
            custs = db.read()
            
            let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
            
            present(control, animated: true)
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}
