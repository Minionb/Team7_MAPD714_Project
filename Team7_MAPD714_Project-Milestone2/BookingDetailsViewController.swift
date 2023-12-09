//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/27/2023
//  Description: Booking Info View Controller

import UIKit
import SQLite3

class BookingDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var bookingIDResult: Int?
    var customerEmail: String = ""
    var booking: BookingInfo?
    var cid : Int = 1
    var bid = 0
    
    var bookingDB = BookingInfoDBManager()
    var customerDB = CustomerInfoDBManager()
    
    var bookingDetails = [["tag":"Customer Name:","detail":""],["tag":"Customer Address:","detail":""],["tag":"City and Country:","detail":""],["tag":"Type of Cruise:","detail":""],["tag":"Start Date:","detail":""],["tag":"Visiting Places:","detail": ""],["tag":"Number of Guests (Adult):","detail":""],["tag":"Number of Guests (Kids):","detail":""],["tag":"Has Senior Guest:","detail":""],["tag":"Number of Nights:","detail":""],["tag":"Price per Person:","detail":""],["tag":"Total Price:","detail":""]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let unwrappedBid = bookingIDResult {
            bid =  unwrappedBid
        }
        let unwrappedBooking = bookingDB.selectBookingsByBookingID(bid: bid)[0]

        booking = unwrappedBooking
        let bidString = String(bid)
        var cidString = ""
        var customerName = ""
        var customerEmail = ""
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
    
        if let unwrappedCustomer = customerDB.getCustomerByCID(cid:cid) {
            customerName = unwrappedCustomer.cfirstname + " " + unwrappedCustomer.clastname
            customerEmail = unwrappedCustomer.cemail
        }
            
        bookingDetails = [["tag":"Booking ID:","detail":bidString],["tag":"Customer Name:","detail":customerName],["tag":"Customer Email:","detail":customerEmail], ["tag":"Type of Cruise:","detail":cruiseTypeString],["tag":"Start Date:","detail":cruiseStartDateString],["tag":"End Date:","detail":cruiseEndDateString],["tag":"Visiting Places:","detail": visitingPlacesString],["tag":"Number of Guests (Adult):","detail":adultNumString],["tag":"Number of Guests (Kids):","detail":kidNumString],["tag":"Has Senior Guest:","detail":hasSeniorString],["tag":"Number of Nights:","detail":nightNumString],["tag":"Price per Person($):","detail":cruisePriceString],["tag":"Total Price($):","detail":totalPriceString]]
        
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
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 10)
        
        cell?.detailTextLabel?.text = detail
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 10)
        
        return cell!
    }
    
    @IBAction func onCancelClicked(_ sender: UIButton) {
        let confirmMessage = "Are you sure you want to cancel this booking with Booking ID: " + String(bid) + "?"
        
        let confirmController = UIAlertController(title: "Confirmation", message: confirmMessage, preferredStyle: .alert)

        // Create the action for confirming cancel order
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            // Delete the order
            self.bookingDB.deleteByID(bid: self.bid)
            
            let statementMessage = "You have successfully cancelled Booking ID: " + String(self.bid) + "."
 
            let statementController = UIAlertController(title: "Successfully Cancelled Booking", message: statementMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel) { [weak self] (_) in
                guard let self = self else {
                    return
                }
                let control = storyboard?.instantiateViewController(withIdentifier: "profileView") as! CustomerProfileViewController
                
                control.customerEmail = self.customerEmail
                control.cid = self.cid
                
                self.present(control, animated: true)
            }
            statementController.addAction(okAction)
            self.present(statementController, animated: true, completion: nil)
        }

        // Create the action for canceling
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in

        }

        // Add the actions to the alert controller
        confirmController.addAction(confirmAction)
        confirmController.addAction(cancelAction)
        
        self.present(confirmController, animated: true, completion: nil)
        
    }
    
}
