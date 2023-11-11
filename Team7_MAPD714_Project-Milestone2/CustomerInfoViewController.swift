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
    
    // Bring result passed from the Package Details screen
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
    
    
    // Register Components from story board
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var customerInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create name label
        let nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create name text field
        nameInput = UITextField()
        nameInput?.borderStyle = .roundedRect
        nameInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the name label and name text field to the view
        view.addSubview(nameLabel)
        if let nameInput = nameInput{
            view.addSubview(nameInput)
            
            // Set the name label and name text field constraints
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 30),
                nameInput.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
                nameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                nameInput.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                nameInput.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
                nameInput.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
            ])
        }
        
        // Create address label
        let addressLabel = UILabel()
        addressLabel.text = "Address:"
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create address text field
        addressInput = UITextField()
        addressInput?.borderStyle = .roundedRect
        addressInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the address label and address text field to the view
        view.addSubview(addressLabel)
        
        if let addressInput = addressInput{
            view.addSubview(addressInput)
            
            // Set the address label and address text field constraints
            NSLayoutConstraint.activate([
                addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                addressLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 40),
                addressInput.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
                addressInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                addressInput.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
                addressInput.widthAnchor.constraint(equalTo: addressLabel.widthAnchor),
                addressInput.heightAnchor.constraint(equalTo: addressLabel.heightAnchor),
            ])
        }
        
        // Create City and Country label
        let cityCountryLabel = UILabel()
        cityCountryLabel.text = "City and Country:"
        cityCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create City and Country text field
        cityCountryInput = UITextField()
        cityCountryInput?.borderStyle = .roundedRect
        cityCountryInput?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the City and Country label and address text field to the view
        view.addSubview(cityCountryLabel)
        
        if let cityCountryInput = cityCountryInput{
            view.addSubview(cityCountryInput)
            
            // Set the City and Country label and address text field constraints
            NSLayoutConstraint.activate([
                cityCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                cityCountryLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor, constant: 40),
                cityCountryInput.leadingAnchor.constraint(equalTo: cityCountryLabel.trailingAnchor, constant: 8),
                cityCountryInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                cityCountryInput.centerYAnchor.constraint(equalTo: cityCountryLabel.centerYAnchor),
                cityCountryInput.widthAnchor.constraint(equalTo: cityCountryLabel.widthAnchor),
                cityCountryInput.heightAnchor.constraint(equalTo: cityCountryLabel.heightAnchor),
            ])
        }
        
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
        // Create City and Country label
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
            // Action to perform when the button is tapped
        let control = storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        
        let customerName = nameInput?.text
        let customerAddress = addressInput?.text
        let cityAndCountry = cityCountryInput?.text
        let seniorGuestSegmentedControlVaule = seniorGuestSegmentedControl?.selectedSegmentIndex
        var hasSenior = "No"
        if (seniorGuestSegmentedControlVaule == 0){
            hasSenior = "Yes"
        }
        else{
            hasSenior = "No"
        }
        
        let numberOfAdultsString = numberOfAdultsInput?.text
        let numberOfKidsString = numberOfKidsInput?.text
        
        var numberOfAdults: Int?
        var numberOfKids: Int?
        
        // Get the text from the text field
        
        if let number = Int(numberOfAdultsString ?? "") {
                // Use the converted integer here
                numberOfAdults = number
            } else {
                // Print an error message if the conversion fails
                print("Invalid number")
            }


            // Attempt to convert the input text to an integer
            if let number = Int(numberOfKidsString ?? "") {
                // Use the converted integer here
                numberOfKids = number
            } else {
                // Print an error message if the conversion fails
                print("Invalid number")
            }
        
        // Pass the info to Payment Screen
        control.customerNameResult = customerName
        control.customerAddressResult = customerAddress
        control.cityAndCountryResult = cityAndCountry
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
        
        present(control, animated: true)
        }
    
}
    


