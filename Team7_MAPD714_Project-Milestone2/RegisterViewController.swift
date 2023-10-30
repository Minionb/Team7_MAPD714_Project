//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Cole Anam on 30/10/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonOnClicked(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty == true || lastNameTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || ageTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true) {
            errorTextLabel.textColor = .systemRed
        }
        else {
            errorTextLabel.textColor = .white
            
            let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
            
            present(control, animated: true)
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}
