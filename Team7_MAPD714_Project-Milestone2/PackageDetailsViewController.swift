//
//  PackageDetailsViewController.swift
//  File Name: Team7_MAPD714_Project-Milestone2

//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 10/30/2023
//  Description: Cruise Packages Details Screen

import UIKit

class PackageDetailsViewController: UIViewController {
    
    
    // Register UI Components
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    
    @IBOutlet weak var cruiseTypeResultLabel: UILabel!
    
    @IBOutlet weak var vistingPlaceResultLabel: UILabel!
    
    @IBOutlet weak var cruisePriceResultLabel: UILabel!
    
    @IBOutlet weak var cruiseDurationResultLabel: UILabel!
    
    @IBOutlet weak var cruiseStartDateResultLabel: UILabel!
    
    @IBOutlet weak var cruiseEndDateResultLabel: UILabel!
    
    
    // Bring result passed from the search screen
    var IDResult: String?
    
    var cruiseTypeResult: String?
    
    var vistingPlaceResult: String?
    
    var cruisePriceResult: String?
    
    var cruiseDurationResult: String?
    
    var cruiseStartDateResult: String?
    
    var cruiseEndDateResult: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display relative images, visting places, cruise price, duration, start date and end date
        let image1Name = (IDResult ?? "") + "_1"
        
        let image2Name = (IDResult ?? "") + "_2"
        
        let originalImage1 = UIImage(named: image1Name)
        
        let originalImage2 = UIImage(named: image2Name)
        
        // Resize Image 1
        let newSize1 = CGSize(width: 300, height:150)

        UIGraphicsBeginImageContextWithOptions(newSize1, false, 0.0)
        
        originalImage1?.draw(in: CGRect(origin: .zero, size: newSize1))

        let image1 = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        firstImage.image = image1
        
        // Resize Image 2
        let newSize2 = CGSize(width: 300, height:150)

        UIGraphicsBeginImageContextWithOptions(newSize2, false, 0.0)
        
        originalImage2?.draw(in: CGRect(origin: .zero, size: newSize1))

        let image2 = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        firstImage.image = image1
        
        secondImage.image = image2
        
        cruiseTypeResultLabel.text = cruiseTypeResult
        
        vistingPlaceResultLabel.text = vistingPlaceResult

        cruisePriceResultLabel.text = "$" + (cruisePriceResult ?? "")
        
        cruiseDurationResultLabel.text = (cruiseDurationResult ?? "") + "-Night"
        
        cruiseStartDateResultLabel.text = cruiseStartDateResult
        
        cruiseEndDateResultLabel.text = cruiseEndDateResult
        
        
        
    }
    

}
