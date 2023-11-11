//
//  CruiseReservationInfoViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 3
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/13/2023
//  Description: Cruise Reservation Info Screen

import UIKit

class CruiseReservationInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Bring result passed from the Payment screen
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
    
    @IBOutlet weak var cruiseImage: UIImageView!
    
    // Initial dictionary list of visting places, cruise price, duration, start date and end date for table view use
    
    var reservationDetails = [["tag":"Customer Name:","detail":""],["tag":"Customer Address:","detail":""],["tag":"City and Country:","detail":""],["tag":"Type of Cruise:","detail":""],["tag":"Start Date:","detail":""],["tag":"Visiting Places:","detail": ""],["tag":"Number of Guests (Adult):","detail":""],["tag":"Number of Guests (Kids):","detail":""],["tag":"Has Senior Guest:","detail":""],["tag":"Number of Nights:","detail":""],["tag":"Price per Person:","detail":""],["tag":"Total Price:","detail":""]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cruiseType = cruiseTypeResult
        else {return}
        
        let originalImage = UIImage(named: cruiseType)
        
        // Resize Image
        let newSize = CGSize(width: 60, height:45)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        originalImage?.draw(in: CGRect(origin: .zero, size: newSize))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        cruiseImage.image = image
        
        let customerName = (customerNameResult ?? "")
        
        let customerAddress = (customerAddressResult ?? "")
        
        let cityAndCountry = (cityAndCountryResult ?? "")
        
        let vistingPlaces = (vistingPlaceResult ?? "")
        
        let hasSenior = (hasSeniorResult ?? "")
        
        let numberOfAdults = (numberOfAdultsResult ?? 0)
        
        let numberOfKids = (numberOfKidsResult ?? 0)
        
        let numberOfAdultsString = String(numberOfAdults)
        
        let numberOfKidsString = String(numberOfKids)
        
        let cruisePriceString = "$" + (cruisePriceResult ?? "")
        
        guard let cruisePrice = Int(cruisePriceResult ?? "") else { return }
        
        let cruiseDuration = (cruiseDurationResult ?? "") + "-Night"
        
        let cruiseStartDate = (cruiseStartDateResult ?? "")
        
        let cruiseEndDate = (cruiseEndDateResult ?? "")
        
        let totalPrice = cruisePrice * (numberOfAdults + numberOfKids)
        
        let totalPriceString = "$" + String(totalPrice)
        
        // Map the value of previous screen for table view use
        reservationDetails = [ ["tag":"Customer Name:","detail":customerName],["tag":"Customer Address:","detail":customerAddress],["tag":"City and Country:","detail":cityAndCountry],["tag":"Type of Cruise:","detail":cruiseType],["tag":"Start Date:","detail":cruiseStartDate],["tag":"Visiting Places:","detail": vistingPlaces],["tag":"Number of Guests (Adult):","detail":numberOfAdultsString],["tag":"Number of Guests (Kids):","detail":numberOfKidsString],["tag":"Has Senior Guest:","detail":hasSenior],["tag":"Number of Nights:","detail":cruiseDuration],["tag":"Price per Person:","detail":cruisePriceString],["tag":"Total Price:","detail":totalPriceString]]

    }
    
    let cruiseReservationInfoIdentifier = "PackageDetailsIdentifier"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return reservationDetails.count
      }
    
    // Display visting places, cruise price, duration, start date and end date using table view for better layout
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cruiseReservationInfoIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: cruiseReservationInfoIdentifier)
        }
        
        let rowData = reservationDetails[indexPath.row]
        
        
        let tag = String(describing: rowData["tag"] ?? "")
        
        let detail = String(describing: rowData["detail"] ?? "")
        
        cell?.textLabel?.text =  tag

        
        cell?.detailTextLabel?.text = detail
        
        return cell!
    }
}
