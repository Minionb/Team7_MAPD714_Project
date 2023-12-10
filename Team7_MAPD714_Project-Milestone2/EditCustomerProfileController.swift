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
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var errorLabelText: UILabel!
    
    let ageData = ["18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100"]
    
    var db = CustomerInfoDBManager()
    var customer: CustomerInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agePicker.dataSource = self
        agePicker.delegate = self
        
        errorLabelText.textColor = .white
        
        customer = db.getCustomer(cemail: customerEmail, cpassword: customerPassword)!
        
        addressTextField.text = customer?.caddress
        cityTextField.text = customer?.ccity
        countryTextField.text = customer?.ccountry
        phoneNumTextField.text = customer?.ctelephone
        passwordTextField.text = customer?.cpassword
        
        let selectedAgeIndex = (customer?.cage ?? 0) - 18
        
        // Set the default selected age
            agePicker.selectRow(selectedAgeIndex, inComponent: 0, animated: false)
        
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
            let row = agePicker.selectedRow(inComponent: 0)
            let selectedAge = ageData[row]
            guard let cage = Int(selectedAge) else { return }
            
            customer?.cage = cage

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

extension EditCustomerProfileController: UIPickerViewDataSource{
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView,
                numberOfRowsInComponent component: Int) -> Int {
    return ageData.count
}
}

extension EditCustomerProfileController: UIPickerViewDelegate{
// MARK: Picker Delegate Methods
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ageData[row]
}
}


