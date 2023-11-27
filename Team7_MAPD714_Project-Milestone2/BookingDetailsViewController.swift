//
//  BookingDetailsViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Hilary Ng on 26/11/2023.
//

import UIKit
import SQLite3

class BookingDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var bookingIDResult: Int?
    var booking: BookingInfo?
    
    var db = BookingInfoDBManager()
    
    var bookingDetails = [["tag":"Customer Name:","detail":""],["tag":"Customer Address:","detail":""],["tag":"City and Country:","detail":""],["tag":"Type of Cruise:","detail":""],["tag":"Start Date:","detail":""],["tag":"Visiting Places:","detail": ""],["tag":"Number of Guests (Adult):","detail":""],["tag":"Number of Guests (Kids):","detail":""],["tag":"Has Senior Guest:","detail":""],["tag":"Number of Nights:","detail":""],["tag":"Price per Person:","detail":""],["tag":"Total Price:","detail":""]]

    override func viewDidLoad() {
        super.viewDidLoad()
        var bid = 0
        if let unwrappedBid = bookingIDResult {
            bid =  unwrappedBid
        }
        let unwrappedBooking = db.selectBookingsByBookingID(bid: bid)[0]

        booking = unwrappedBooking
        let bidString = String(bid)
        var cidString = ""
        var cruiseTypeString = ""
        var cruiseStartDateString = ""
        var cruiseEndDateString = ""
        var visitingPlacesString = ""
        var hasSeniorString = ""
        var adultNumString = ""
        var kidNumString = ""
        var nightNumString = ""
        var cruisePriceString = ""
        var totalPriceString = ""
    
        if let unwrappedCidString = booking?.cid {
            cidString = String(unwrappedCidString)
        }
        
        if let unwrappedCruiseTypeString = booking?.bcruiseType {
            cruiseTypeString = String(unwrappedCruiseTypeString)
        }
        
        if let unwrappedCruiseStartDateString = booking?.bcruiseStartDate {
            cruiseStartDateString = String(unwrappedCruiseStartDateString)
        }
        
        if let unwrappedCruiseEndDateString = booking?.bcruiseEndDate {
            cruiseEndDateString = String(unwrappedCruiseEndDateString)
        }
        
        if let unwrappedVisitingPlacesString = booking?.bvisitingPlaces {
            visitingPlacesString = String(unwrappedVisitingPlacesString)
        }
        
        if let unwrappedHasSeniorString = booking?.bhasSenior {
            hasSeniorString = String(unwrappedHasSeniorString)
        }
        
        if let unwrappedAdultNumString = booking?.badultNum {
            adultNumString = String(unwrappedAdultNumString)
        }
        
        if let unwrappedKidNumString = booking?.bkidNum {
            kidNumString = String(unwrappedKidNumString)
        }
        
        if let unwrappedNightNumString = booking?.bnightNum {
            nightNumString = String(unwrappedNightNumString)
        }
        
        if let unwrappedCruisePriceString = booking?.bcruisePrice {
            cruisePriceString = String(unwrappedCruisePriceString)
        }
        
        if let unwrappedTotalPriceString = booking?.btotalPrice {
            totalPriceString = String(unwrappedTotalPriceString)
        }
          
            
        bookingDetails = [["tag":"Booking ID:","detail":bidString],["tag":"Customer ID:","detail":cidString],["tag":"Type of Cruise:","detail":cruiseTypeString],["tag":"Start Date:","detail":cruiseStartDateString],["tag":"End Date:","detail":cruiseEndDateString],["tag":"Visiting Places:","detail": visitingPlacesString],["tag":"Number of Guests (Adult):","detail":adultNumString],["tag":"Number of Guests (Kids):","detail":kidNumString],["tag":"Has Senior Guest:","detail":hasSeniorString],["tag":"Number of Nights:","detail":nightNumString],["tag":"Price per Person:","detail":cruisePriceString],["tag":"Total Price:","detail":totalPriceString]]
        
    }
    
    let bookingDetalsIdentifier = "bookingDetalsIdentifier"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return bookingDetails.count
      }
    
    // Displying Booking Details
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: bookingDetalsIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: bookingDetalsIdentifier)
        }
        
        let rowData = bookingDetails[indexPath.row]
        let tag = String(describing: rowData["tag"] ?? "")
        
        let detail = String(describing: rowData["detail"] ?? "")
        
        cell?.textLabel?.text = tag

        
        cell?.detailTextLabel?.text = detail
        
        return cell!
    }
    

}
