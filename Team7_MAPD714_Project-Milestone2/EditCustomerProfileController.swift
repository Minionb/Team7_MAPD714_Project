//
//  EditCustomerProfileController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Cole Anam on 27/11/23.
//

import UIKit

class EditCustomerProfileController: UIViewController {
    
    var customerEmail: String = ""
    var customerPassword: String = ""
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabelText: UILabel!
    
    var db = CustomerInfoDBManager()
    var customer: CustomerInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabelText.textColor = .white
        
        customer = db.getCustomer(cemail: customerEmail, cpassword: customerPassword)!
        
        addressTextField.text = customer?.caddress
        cityTextField.text = customer?.ccity
        countryTextField.text = customer?.ccountry
        phoneNumTextField.text = customer?.ctelephone
        passwordTextField.text = customer?.cpassword
    }
    
    @IBAction func saveChangesButtonClicked(_ sender: Any) {
        
        if (addressTextField.text?.isEmpty == true || cityTextField.text?.isEmpty == true || countryTextField.text?.isEmpty == true || phoneNumTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            errorLabelText.textColor = .systemRed
        }
        else {
            
            customer?.caddress = addressTextField.text!
            customer?.ccity = cityTextField.text!
            customer?.ccountry = countryTextField.text!
            customer?.ctelephone = phoneNumTextField.text!
            customer?.cpassword = passwordTextField.text!
            
            db.updateCustomer(customerInfo: customer!)
            
            let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
            
            control.customerEmail = customer!.cemail
            
            present(control, animated: true)
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
        
        control.customerEmail = customer!.cemail
        
        present(control, animated: true)
    }
    
}

