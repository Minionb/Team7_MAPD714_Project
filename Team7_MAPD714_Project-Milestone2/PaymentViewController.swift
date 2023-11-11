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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a label
                let label = UILabel()
                
                // Set the text
                label.text = customerNameResult
                
                // Set the font
                label.font = UIFont.systemFont(ofSize: 18)
                
                // Set the text color
                label.textColor = UIColor.black
                
                // Set the label's position and size using Auto Layout
                label.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(label)
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
    }
    
    
    @IBAction func onConfirmPressed(_ sender: UIButton) {
        
        let control = storyboard?.instantiateViewController(withIdentifier: "cruiseReservationInfo") as! CruiseReservationInfoViewController
        
        // Pass the info to Cruise Reservation Info Screen
        control.customerNameResult = customerNameResult
        control.customerAddressResult = customerAddressResult
        control.cityAndCountryResult = cityAndCountryResult
        control.hasSeniorResult = hasSeniorResult
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
