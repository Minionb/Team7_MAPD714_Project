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
import SQLite3

class PaymentViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var Confirm: UIButton!
    
    // Pass from Login Screen
    var cid : Int = 0
    
    var customerEmail : String = ""
    
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
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var expiryMonthTextField: UITextField!
    
    @IBOutlet weak var expiryYearTextField: UITextField!
    
    @IBOutlet weak var payTypeLabel: UILabel!
    
    @IBOutlet weak var emptyFieldMessageLabel: UILabel!
    
    
    var db = BookingInfoDBManager()
    var bookings = Array<BookingInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardNumTextField.delegate = self
        expiryMonthTextField.delegate = self
        expiryYearTextField.delegate = self
        
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
        
//        NSLayoutConstraint.activate([
//            visaButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
//            debitButton.leadingAnchor.constraint(equalTo: visaButton.trailingAnchor, constant: 80),
//            applepayButton.leadingAnchor.constraint(equalTo: visaButton.trailingAnchor, constant: 80),
//            paypalButton.leftAnchor.constraint(equalTo: applepayButton.trailingAnchor, constant: 80)
//        ])
    }
    
    // Card payment info validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Numbers only
        let allowedCharsSet = CharacterSet.decimalDigits
        let replaceStringCharSet = CharacterSet(charactersIn: string)
        guard allowedCharsSet.isSuperset(of: replaceStringCharSet) else {
            return false
        }
        
        // Card date validation
        if (textField.placeholder == "mm" || textField.placeholder == "yy") {
            // max length 2 digits
            let maxLength = 2
            if let text = textField.text, text.count >= maxLength, string != "" {
                return false
            }
        }
        // Card number validation
        else {
            // max length 16 digits
            let maxLength = 16
            if let text = textField.text, text.count >= maxLength, string != "" {
                return false
            }
        }
        
        return true
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
    
    func isValidExpiryDate(month: String, year: String) -> Bool {
        // Parse the input values as integers
//        guard let inputMonth = Int(month), let inputYear = Int(year) else {
//            return false
//        }
        guard let inputYear = Int(year), inputYear >= 0 else {
            return false
        }


        guard month.count == 2, let inputMonth = Int(month), inputMonth >= 1, inputMonth <= 12 else {
            return false
        }

        // Perform basic validation checks
        let currentYear = Calendar.current.component(.year, from: Date()) % 100
        let currentMonth = Calendar.current.component(.month, from: Date())

        if inputYear < currentYear || (inputYear == currentYear && inputMonth < currentMonth) {
            return false // Expiry date is in the past
        }

        if inputMonth < 1 || inputMonth > 12 {
            return false // Invalid month
        }
        return true
    }
    
    @IBAction func onConfirmPressed(_ sender: UIButton) {
        
        let control = storyboard?.instantiateViewController(withIdentifier: "cruiseReservationInfo") as! CruiseReservationInfoViewController
        
        var cardNum = cardNumTextField.text
        var sizeOfCardNum = cardNum?.utf16.count
        print(sizeOfCardNum)
        var expiryMonth = ""
        var expiryYear = ""
        expiryMonth = expiryMonthTextField.text ?? ""
        expiryYear = expiryYearTextField.text ?? ""
        
        // Check if there are any empty fields or payment type not selected and show error message
        if (cardNumTextField.text?.isEmpty == true ||
            fullNameTextField.text?.isEmpty == true ||
            expiryMonthTextField.text?.isEmpty == true ||
            expiryYearTextField.text?.isEmpty == true) {
            emptyFieldMessageLabel.text = "One or more fields are empty"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        else if (payTypeLabel.text == "Payment type not selected") {
            emptyFieldMessageLabel.text = "Payment type not selected"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        else if (sizeOfCardNum != 16){
            emptyFieldMessageLabel.text = "Card number is not valid"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        else if (!isValidExpiryDate(month: expiryMonth, year: expiryYear)){
            emptyFieldMessageLabel.text = "Card expiry date is not valid"
            emptyFieldMessageLabel.textColor = .systemRed
        }
        
        else {
            // Insert Booking Details to DB
            var nightNum = 0
            var cruisePrice = 0
            
            if let unwrappednNightNum = Int(cruiseDurationResult ?? "") {
                nightNum = unwrappednNightNum
            }
            
            if let unwrappedCruisePrice = Int(cruisePriceResult ?? "") {
                cruisePrice = unwrappedCruisePrice
            }
            
            let numberOfAdults = (numberOfAdultsResult ?? 0)
            
            let numberOfKids = (numberOfKidsResult ?? 0)
            
            let totalPrice = cruisePrice * (numberOfAdults + numberOfKids)

            db.insert(cid: cid, bcruiseType: cruiseTypeResult ?? "", bcruiseStartDate: cruiseStartDateResult ?? "",bcruiseEndDate: cruiseEndDateResult ?? "", bvisitingPlaces: vistingPlaceResult ?? "", badultNum: numberOfAdultsResult ?? 0, bkidNum: numberOfKidsResult ?? 0, bhasSenior: hasSeniorResult ?? "", bnightNum: nightNum, bcruisePrice: cruisePrice, btotalPrice: totalPrice)
            
            bookings = db.read()
            print(bookings)
            
            emptyFieldMessageLabel.textColor = .white
            print("payment")
            print(cid)
            
            // Pass the info to Cruise Reservation Info Screen
            // DOES NOT INCLUDE PAYMENT INFO
            control.cid = cid
            control.customerEmail = customerEmail
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
