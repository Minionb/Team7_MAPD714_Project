//
//  PaymentViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 3
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/13/2023
//  Description: Payment Screen

import UIKit

class PaymentViewController: UIViewController {
    
    
    @IBOutlet weak var Confirm: UIButton!
    
    // Bring result passed from the Customer Info screen
    var customerNameResult: String?
    
    var customerAddressResult: String?
    
    var cityAndCountryResult: String?
    
    var hasSeniorResult: String?
    
    var numberOfAdultsResult: Int?
    
    var numberOfKidsResult: Int?
    
    var IDResult: String?
    
    var cruiseTypeResult: String?
    
    var vistingPlaceResult: String?
    
    var cruisePriceResult: String?
    
    var cruiseDurationResult: String?
    
    var cruiseStartDateResult: String?
    
    var cruiseEndDateResult: String?
    
    @IBOutlet weak var cardNumTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var expiryMonthTextField: UITextField!
    
    @IBOutlet weak var expiryYearTextField: UITextField!
    
    @IBOutlet weak var payTypeLabel: UILabel!
    
    @IBOutlet weak var emptyFieldMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyFieldMessageLabel.textColor = .white
        
        // Visa payment option button
        let visaButton = UIButton(type: .custom)
        visaButton.setImage(UIImage(named: "Visa_icon"), for: .normal)
        visaButton.contentMode = .scaleAspectFit
        visaButton.frame = CGRect(x: 20, y: 75, width: 100, height: 100)
        visaButton.addTarget(self, action: #selector(visaTapped), for: .touchUpInside)
        view.addSubview(visaButton)
        
        // Debit payment option button
        let debitButton = UIButton(type: .custom)
        debitButton.setImage(UIImage(named: "debit_mastercard"), for: .normal)
        debitButton.contentMode = .scaleAspectFit
        debitButton.frame = CGRect(x: 100, y: 75, width: 100, height: 100)
        debitButton.addTarget(self, action: #selector(debitTapped), for: .touchUpInside)
        view.addSubview(debitButton)
        
        // Visa payment option button
        let applepayButton = UIButton(type: .custom)
        applepayButton.setImage(UIImage(named: "Applepay_icon"), for: .normal)
        applepayButton.contentMode = .scaleAspectFit
        applepayButton.frame = CGRect(x: 180, y: 75, width: 100, height: 100)
        applepayButton.addTarget(self, action: #selector(applepayTapped), for: .touchUpInside)
        view.addSubview(applepayButton)
        
        // Visa payment option button
        let paypalButton = UIButton(type: .custom)
        paypalButton.setImage(UIImage(named: "Paypal_icon"), for: .normal)
        paypalButton.contentMode = .scaleAspectFit
        paypalButton.frame = CGRect(x: 260, y: 75, width: 100, height: 100)
        paypalButton.addTarget(self, action: #selector(paypalTapped), for: .touchUpInside)
        view.addSubview(paypalButton)
    }
    
    @objc func visaTapped() {
        print("Visa option selected")
        payTypeLabel.text = "Visa"
    }
    
    @objc func debitTapped() {
        print("Debit option selected")
        payTypeLabel.text = "Debit"
    }
    
    @objc func applepayTapped() {
        print("ApplePay option selected")
        payTypeLabel.text = "Applepay"
    }
    
    @objc func paypalTapped() {
        print("Paypal option selected")
        payTypeLabel.text = "Paypal"
    }
    
    @IBAction func onConfirmPressed(_ sender: UIButton) {
        
        let control = storyboard?.instantiateViewController(withIdentifier: "cruiseReservationInfo") as! CruiseReservationInfoViewController
        
        // Check if there are any empty fields or payment type not selected and show error message
        if (cardNumTextField.text?.isEmpty == true ||
            firstNameTextField.text?.isEmpty == true ||
            lastNameTextField.text?.isEmpty == true ||
            expiryMonthTextField.text?.isEmpty == true ||
            expiryYearTextField.text?.isEmpty == true) {
            emptyFieldMessageLabel.text = "One or more fields are empty"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        else if (payTypeLabel.text == "Payment type not selected") {
            emptyFieldMessageLabel.text = "Payment type not selected"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        else {
            emptyFieldMessageLabel.textColor = .white
            
            // Pass the info to Cruise Reservation Info Screen
            // DOES NOT INCLUDE PAYMENT INFO
            control.customerNameResult = customerNameResult
            control.customerAddressResult = customerAddressResult
            control.cityAndCountryResult = cityAndCountryResult
            control.hasSeniorResult = hasSeniorResult
            control.numberOfAdultsResult = numberOfAdultsResult
            control.numberOfKidsResult = numberOfKidsResult
            control.IDResult = IDResult
            control.cruiseTypeResult = cruiseTypeResult
            control.vistingPlaceResult = vistingPlaceResult
            control.cruisePriceResult = cruisePriceResult
            control.cruiseDurationResult = cruiseDurationResult
            control.cruiseStartDateResult = cruiseStartDateResult
            control.cruiseEndDateResult = cruiseEndDateResult

            // Got to Cruise Reservation Screen
            present(control, animated: true)
        }

    }
    

}
