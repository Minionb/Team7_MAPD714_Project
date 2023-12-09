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
    @IBOutlet weak var agePicker: UIPickerView!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    
    // CustomerInfo database test code
    var db = CustomerInfoDBManager()
    var custs = Array<CustomerInfo>()
    
    let ageData = ["18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100"]
    
    let countryData = [
        "Canada",
        "China",
        "Mexico",
        "United Kingdom",
        "United States",
    ]
    
    let canadaData = [
        "NL",
        "PE",
        "NS",
        "NB",
        "QC",
        "ON",
        "MB",
        "SK",
        "AB",
        "BC",
        "YT",
        "NT",
        "NU"
    ]
    
    let usData = [
        "AL",
        "AK",
        "AS",
        "AZ",
        "AR",
        "CA",
        "CO",
        "CT",
        "DE",
        "DC",
        "FM",
        "FL",
        "GA",
        "GU",
        "HI",
        "ID"
    ]
    
    var selectedCountry = "Select Country"
    var selectedState = "Select State"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agePicker.dataSource = self
        agePicker.delegate = self
        
        errorTextLabel.textColor = .white
        
        //db.deleteAllCustomers()
        custs = db.read()
        
        // Country dropdown
        let countryActionClosure = { (action: UIAction) in (self.selectedCountry = action.title)
            print(self.selectedCountry)
            
            // State dropdown
            let stateActionClosure = { (action: UIAction) in (self.selectedState = action.title)
                print(self.selectedState)
            }
            var menuStateChildren: [UIMenuElement] = [UIAction(title: "Select Province", handler: stateActionClosure)]
            if (self.selectedCountry == "Canada") {
                menuStateChildren = []
                menuStateChildren.append(UIAction(title: "Select Province", handler: stateActionClosure))
                for state in self.canadaData {
                    menuStateChildren.append(UIAction(title: state,  handler: stateActionClosure))
                }
                
            }
            else if (self.selectedCountry == "United States") {
                menuStateChildren = []
                menuStateChildren.append(UIAction(title: "Select State", handler: stateActionClosure))
                for state in self.usData {
                    menuStateChildren.append(UIAction(title: state,  handler: stateActionClosure))
                }
            }
            
            self.stateButton.menu = UIMenu(options: .displayInline, children: menuStateChildren)
            self.stateButton.showsMenuAsPrimaryAction = true
            self.stateButton.changesSelectionAsPrimaryAction = true
        }
        var menuCountryChildren: [UIMenuElement] = []
        menuCountryChildren.append(UIAction(title: "Select Country",  handler: countryActionClosure))
        for country in countryData {
            menuCountryChildren.append(UIAction(title: country,  handler: countryActionClosure))
        }
        countryButton.menu = UIMenu(options: .displayInline, children: menuCountryChildren)
        countryButton.showsMenuAsPrimaryAction = true
        countryButton.changesSelectionAsPrimaryAction = true
        
        
        
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegex = "^[+]?[0-9]{6,}$" // Regular expression pattern for phone number validation
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidAge(ageString: String) -> Bool {
        guard let age = Int(ageString) else {
            return false // Invalid integer conversion
        }
        
        let minimumAge = 0
        let maximumAge = 150
        
        return age >= minimumAge && age <= maximumAge
    }
    
    @IBAction func signUpButtonOnClicked(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty == true || lastNameTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true ||
            cityTextField.text?.isEmpty == true ||
            telephoneTextField.text?.isEmpty == true ||
            selectedCountry == "Select Country" ||
            selectedState == "Select State") {
            errorTextLabel.textColor = .systemRed
        }
        else if(!isValidEmail(email: emailTextField.text ?? "")){
            errorTextLabel.text = "Invalid email"
            errorTextLabel.textColor = .systemRed
        }
        else if (!isValidPhoneNumber(phoneNumber: telephoneTextField.text ?? "")){
            errorTextLabel.text = "Invalid phone number"
            errorTextLabel.textColor = .systemRed
        }
        else {
            errorTextLabel.textColor = .white
            
            
            // CustomerInfo database test code
            let cfirstname = firstNameTextField.text!
            let clastname = lastNameTextField.text!
            let cemail = emailTextField.text!
            let cpassword = passwordTextField.text!
            let row = agePicker.selectedRow(inComponent: 0)
            let selectedAge = ageData[row]
            guard let cage = Int(selectedAge) else { return }
            
            //guard let cage = Int(ageTextField.text!) else { return }
            let caddress = addressTextField.text!
            let ccity = cityTextField.text!
            let ccountry = selectedCountry + ", " + selectedState
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
                    let control = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
                    
                    self.present(control, animated: true)
                }

                // Add the action to the alert controller
                alertController.addAction(okAction)

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
                
                firstNameTextField.text = ""
                lastNameTextField.text = ""
                emailTextField.text = ""
                passwordTextField.text = ""
                addressTextField.text = ""
                cityTextField.text = ""
                selectedCountry = "Select Country"
                selectedState = "Select State"
                telephoneTextField.text = ""
            }
        }
    }
    
    @IBAction func guestButtonOnClicked(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        present(control, animated: true)
    }
    
}

// Picker Data Source Methods

extension RegisterViewController: UIPickerViewDataSource{
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView,
                numberOfRowsInComponent component: Int) -> Int {
    return ageData.count
}
}

extension RegisterViewController: UIPickerViewDelegate{
// MARK: Picker Delegate Methods
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ageData[row]
}
}
