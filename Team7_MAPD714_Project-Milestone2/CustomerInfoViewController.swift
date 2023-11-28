//
//  CustomerInfoViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 3
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/13/2023
//  Description: Customer Info Screen

import UIKit

class CustomerInfoViewController: UIViewController {
    
    // CustomerInfo database
    var db = CustomerInfoDBManager()
    var customer : CustomerInfo?
    
    // Bring result passed from the Package Details screen
    var cid : Int = 0
    
    var customerEmail : String = ""
    
    var IDResult: String?
    
    var cruiseTypeResult: String?
    
    var vistingPlaceResult: String?
    
    var cruisePriceResult: String?
    
    var cruiseDurationResult: String?
    
    var cruiseStartDateResult: String?
    
    var cruiseEndDateResult: String?
    
    // Declare different text field component
    var nameInput: UITextField?
    
    var addressInput: UITextField?
    
    var cityCountryInput: UITextField?
    
    var numberOfAdultsInput: UITextField?
    
    var numberOfKidsInput: UITextField?
    
    var seniorGuestSegmentedControl: UISegmentedControl?
    
    var customerName : String = ""
    
    var address : String = ""
    
    var cityCountry : String = ""
    
    
    // Register Components from story board
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var customerInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("customer Info:")
        if let customer = db.getCustomerByEmail(cemail: customerEmail){
            print(customer)
            customerName = customer.cfirstname + " " + customer.clastname
            
            address = customer.caddress
            
            cityCountry = customer.ccity + ", " + customer.ccountry
        }
        // Create name label
        let nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create name result label
        let nameResult = UILabel()
        nameResult.text = customerName
        nameResult.translatesAutoresizingMaskIntoConstraints = false
//        nameInput = UITextField()
//        nameInput?.borderStyle = .roundedRect
//        nameInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the name label and name text field to the view
        view.addSubview(nameLabel)
        view.addSubview(nameResult)
//        if let nameInput = nameInput{
//            view.addSubview(nameInput)
//            nameInput.text = customerName
            // Set the name label and name text field constraints
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 30),
                nameResult.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
                nameResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                nameResult.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                nameResult.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
                nameResult.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
            ])
     //   }
        
        // Create address label
        let addressLabel = UILabel()
        addressLabel.text = "Address:"
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create address result label
        let addressResult = UILabel()
        addressResult.text = address
        addressResult.translatesAutoresizingMaskIntoConstraints = false
        
//        // Create address result label
//        addressInput = UITextField()
//        addressInput?.borderStyle = .roundedRect
//        addressInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the address label and address result to the view
        view.addSubview(addressLabel)
        view.addSubview(addressResult)
        
//        if let addressInput = addressInput{
//            view.addSubview(addressInput)
            
//            addressInput.text = address
            // Set the address label and address text field constraints
            NSLayoutConstraint.activate([
                addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                addressLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 40),
                addressResult.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
                addressResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                addressResult.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
                addressResult.widthAnchor.constraint(equalTo: addressLabel.widthAnchor),
                addressResult.heightAnchor.constraint(equalTo: addressLabel.heightAnchor),
            ])
    //    }
        
        // Create City and Country label
        let cityCountryLabel = UILabel()
        cityCountryLabel.text = "City and Country:"
        cityCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create City and Country result label
        let cityCountryResult = UILabel()
        cityCountryResult.text = cityCountry
        cityCountryResult.translatesAutoresizingMaskIntoConstraints = false
        
//        // Create City and Country text field
//        cityCountryInput = UITextField()
//        cityCountryInput?.borderStyle = .roundedRect
//        cityCountryInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the City and Country label and address text field to the view
        view.addSubview(cityCountryLabel)
        view.addSubview(cityCountryResult)
        
//        if let cityCountryInput = cityCountryInput{
//            view.addSubview(cityCountryInput)
            
//            cityCountryInput.text = cityCountry
            // Set the City and Country label and address text field constraints
            NSLayoutConstraint.activate([
                cityCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                cityCountryLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor, constant: 40),
                cityCountryResult.leadingAnchor.constraint(equalTo: cityCountryLabel.trailingAnchor, constant: 8),
                cityCountryResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                cityCountryResult.centerYAnchor.constraint(equalTo: cityCountryLabel.centerYAnchor),
                cityCountryResult.widthAnchor.constraint(equalTo: cityCountryLabel.widthAnchor),
                cityCountryResult.heightAnchor.constraint(equalTo: cityCountryLabel.heightAnchor),
            ])
     //   }
        
        //Number of guests
        let numberOfGuestsLabel = UILabel()
        numberOfGuestsLabel.text = "No. of Guests:"
        numberOfGuestsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let numberOfAdultsLabel = UILabel()
        numberOfAdultsLabel.text = "Adults:"
        numberOfAdultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberOfAdultsInput = UITextField()
        numberOfAdultsInput?.borderStyle = .roundedRect
        numberOfAdultsInput?.translatesAutoresizingMaskIntoConstraints = false
        
        let numberOfKidsLabel = UILabel()
        numberOfKidsLabel.text = "Kids:"
        numberOfKidsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberOfKidsInput = UITextField()
        numberOfKidsInput?.borderStyle = .roundedRect
        numberOfKidsInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the labels and text fields to the view
        view.addSubview(numberOfGuestsLabel)
        view.addSubview(numberOfAdultsLabel)
        view.addSubview(numberOfKidsLabel)
        
        if let numberOfAdultsInput = numberOfAdultsInput, let numberOfKidsInput = numberOfKidsInput{
            view.addSubview(numberOfAdultsInput)
            view.addSubview(numberOfKidsInput)
            
            // Set the labels and text fields constraints
            NSLayoutConstraint.activate([
                numberOfGuestsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                numberOfGuestsLabel.topAnchor.constraint(equalTo: cityCountryLabel.topAnchor, constant: 40),
                numberOfAdultsLabel.leadingAnchor.constraint(equalTo: numberOfGuestsLabel.trailingAnchor, constant: 8),
                numberOfAdultsInput.leadingAnchor.constraint(equalTo: numberOfAdultsLabel.trailingAnchor, constant: 8),
                numberOfKidsLabel.leadingAnchor.constraint(equalTo: numberOfAdultsInput.trailingAnchor, constant: 8),
                numberOfKidsInput.leadingAnchor.constraint(equalTo: numberOfKidsLabel.trailingAnchor, constant: 8),
                numberOfKidsInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                numberOfAdultsLabel.centerYAnchor.constraint(equalTo: numberOfGuestsLabel.centerYAnchor),
                numberOfAdultsInput.centerYAnchor.constraint(equalTo: numberOfAdultsLabel.centerYAnchor),
                numberOfKidsLabel.centerYAnchor.constraint(equalTo: numberOfAdultsInput.centerYAnchor),
                numberOfKidsInput.centerYAnchor.constraint(equalTo: numberOfKidsLabel.centerYAnchor),
                numberOfAdultsLabel.widthAnchor.constraint(equalTo: numberOfGuestsLabel.widthAnchor, multiplier: 0.4),
                numberOfAdultsLabel.heightAnchor.constraint(equalTo: numberOfGuestsLabel.heightAnchor),
                numberOfAdultsInput.widthAnchor.constraint(equalTo: numberOfAdultsLabel.widthAnchor,multiplier: 0.7),
                numberOfAdultsInput.heightAnchor.constraint(equalTo: numberOfAdultsLabel.heightAnchor),
                numberOfKidsLabel.widthAnchor.constraint(equalTo: numberOfAdultsInput.widthAnchor),
                numberOfKidsLabel.heightAnchor.constraint(equalTo: numberOfAdultsInput.heightAnchor),
                numberOfKidsInput.widthAnchor.constraint(equalTo: numberOfKidsLabel.widthAnchor),
                numberOfKidsInput.heightAnchor.constraint(equalTo: numberOfKidsLabel.heightAnchor),
            ])
        }
        // Create Has Senior Label label
        let seniorGuestsLabel = UILabel()
        seniorGuestsLabel.text = "Have guests over 60?:"
        seniorGuestsLabel.translatesAutoresizingMaskIntoConstraints = false
        

        // Add to View
        view.addSubview(seniorGuestsLabel)
                
        // Create segmented control
        seniorGuestSegmentedControl = UISegmentedControl(items: ["Yes", "No"])
        seniorGuestSegmentedControl?.translatesAutoresizingMaskIntoConstraints = false
        
        if let seniorGuestSegmentedControl = seniorGuestSegmentedControl{
            view.addSubview(seniorGuestSegmentedControl)
            
            // Set the City and Country label and address text field constraints
            NSLayoutConstraint.activate([
                seniorGuestsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                seniorGuestsLabel.topAnchor.constraint(equalTo: numberOfGuestsLabel.topAnchor, constant: 40),
                seniorGuestSegmentedControl.leadingAnchor.constraint(equalTo: seniorGuestsLabel.trailingAnchor, constant: 8),
                seniorGuestSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                seniorGuestSegmentedControl.centerYAnchor.constraint(equalTo: seniorGuestsLabel.centerYAnchor),
                seniorGuestSegmentedControl.widthAnchor.constraint(equalTo: seniorGuestsLabel.widthAnchor, multiplier: 0.7),
                seniorGuestSegmentedControl.heightAnchor.constraint(equalTo: seniorGuestsLabel.heightAnchor),
            ])
        }
        
        // Create a button
        let nextButton = UIButton(type: .system)
        
        // Set the button title
        nextButton.setTitle("Next", for: .normal)
        
        // Set the button size
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        // Set the button's position and size using Auto Layout
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add an action to the button
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        
        var missingFields: [String] = []

        
        // Action to perform when the button is tapped
        let control = storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        
//        let customerName = nameInput?.text
//        let customerAddress = addressInput?.text
//        let cityAndCountry = cityCountryInput?.text

        
        let numberOfAdultsString = numberOfAdultsInput?.text
        let numberOfKidsString = numberOfKidsInput?.text
        
        var numberOfAdults: Int?
        var numberOfKids: Int?
        
//        if (customerName == ""){
//            missingFields.append("Customer Name")
//        }
        
//        if (customerAddress == ""){
//            missingFields.append("Customer Address")
//        }
//
//        if (cityAndCountry == ""){
//            missingFields.append("City and Country")
//        }
        
        
        if let number = Int(numberOfAdultsString ?? "") {
                // Use the converted integer here
                numberOfAdults = number
            } else {
                missingFields.append("Number of Adults")
            }


            // Attempt to convert the input text to an integer
            if let number = Int(numberOfKidsString ?? "") {
                // Use the converted integer here
                numberOfKids = number
            } else {
                missingFields.append("Number of Kids")
            }
        
        let seniorGuestSegmentedControlVaule = seniorGuestSegmentedControl?.selectedSegmentIndex
        var hasSenior = "No"
        if (seniorGuestSegmentedControlVaule == 0){
            hasSenior = "Yes"
        }
        else if (seniorGuestSegmentedControlVaule == 1){
            hasSenior = "No"
        }
        else{
            missingFields.append("Have guests over 60?")
        }
        
        if (missingFields.count == 0){
            // Pass the info to Payment Screen
            control.cid = cid
            control.customerNameResult = customerName
            control.customerAddressResult = address
            control.cityAndCountryResult = cityCountry
            control.hasSeniorResult = hasSenior
            control.numberOfAdultsResult = numberOfAdults
            control.numberOfKidsResult = numberOfKids
            control.IDResult = IDResult
            control.cruiseTypeResult = cruiseTypeResult
            control.vistingPlaceResult = vistingPlaceResult
            control.cruisePriceResult = cruisePriceResult
            control.cruiseDurationResult = cruiseDurationResult
            control.cruiseStartDateResult = cruiseStartDateResult
            control.cruiseEndDateResult = cruiseEndDateResult
            print("profile")
            print(cid)
            // Go to Payment Screen
            present(control, animated: true)
        }
        else{
            let missFieldsString = missingFields.joined(separator: ", ")
            let statement = "Invalid or Missing of the following fields: " + missFieldsString + ". Please fill in the correct information."
            // Create the alert controller
            let alertController = UIAlertController(title: "Invalid or Missing Fields", message: statement, preferredStyle: .alert)

            // Create an action for the alert
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            }

            // Add the action to the alert controller
            alertController.addAction(okAction)

            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
        }
    
}
    


