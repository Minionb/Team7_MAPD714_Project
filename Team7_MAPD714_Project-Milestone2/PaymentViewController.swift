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
    
    var customerName: String?
    var customerAddress: String?
    var cityAndCountry: String?
    var hasSenior: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a label
                let label = UILabel()
                
                // Set the text
                label.text = customerName
                
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
    

}
