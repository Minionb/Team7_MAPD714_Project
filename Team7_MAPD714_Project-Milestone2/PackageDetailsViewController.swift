//
//  PackageDetailsViewController.swift
//  File Name: Team7_MAPD714_Project-Milestone2

//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 10/30/2023
//  Description: Cruise Packages Details Screen

import UIKit

class PackageDetailsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    
    // Register UI Components
    @IBOutlet weak var firstImage: UIImageView!

    @IBOutlet weak var secondImage: UIImageView!

    @IBOutlet weak var cruiseTypeResultLabel: UILabel!

    
    // Bring result passed from the search screen
    var IDResult: String?
    
    var cruiseTypeResult: String?
    
    var vistingPlaceResult: String?
    
    var cruisePriceResult: String?
    
    var cruiseDurationResult: String?
    
    var cruiseStartDateResult: String?
    
    var cruiseEndDateResult: String?
    
    // Initial dictionary list of visting places, cruise price, duration, start date and end date for table view use
    var cruiseDetails = [ ["tag":"Visting Places:","detail":""],["tag":"Cruise Price:","detail":""],["tag":"Cruise Duration","detail":""],["tag":"Cruise Start Date","detail":""],["tag":"Cruise End Date","detail":""]]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vistingPlaces = (vistingPlaceResult ?? "")
        
        let cruisePrice = "$" + (cruisePriceResult ?? "")
        
        let cruiseDuration = (cruiseDurationResult ?? "") + "-Night"
        
        let cruiseStartDate = (cruiseStartDateResult ?? "")
        
        let cruiseEndDate = (cruiseEndDateResult ?? "")
        
        // Map the value of visting places, cruise price, duration, start date and end date passed from the search screen for table view use
        cruiseDetails = [ ["tag":"Visting Places:","detail":vistingPlaces],["tag":"Cruise Price:","detail":cruisePrice],["tag":"Cruise Duration","detail":cruiseDuration],["tag":"Cruise Start Date","detail":cruiseStartDate],["tag":"Cruise End Date","detail":cruiseEndDate]]

        
        // Display relative images
        
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
        

        secondImage.image = image2

        cruiseTypeResultLabel.text = cruiseTypeResult
        
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
        let control = storyboard?.instantiateViewController(withIdentifier: "customerInfo") as! CustomerInfoViewController
        
        present(control, animated: true)
        }
    
    let packageDetailsIdentifier = "PackageDetailsIdentifier"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return cruiseDetails.count
      }
    
    // Display visting places, cruise price, duration, start date and end date using table view for better layout
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: packageDetailsIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: packageDetailsIdentifier)
        }
        
        let rowData = cruiseDetails[indexPath.row]
        
        
        let tag = String(describing: rowData["tag"] ?? "")
        
        let detail = String(describing: rowData["detail"] ?? "")
        
        cell?.textLabel?.text =  tag

        
        cell?.detailTextLabel?.text = detail
        
        return cell!
    }
    
    

}
