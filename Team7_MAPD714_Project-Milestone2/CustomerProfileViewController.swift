//
//  CustomerProfileViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Hilary Ng on 26/11/2023.
//

import UIKit
import SQLite3

class CustomerProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // Pass from Login Screen
    var cid = 3
    
    var db = BookingInfoDBManager()
    var bookings = Array<BookingInfo>()
  
    
    var bookingDetails = [ ["tag":"Booking ID:","detail":""], ["tag":"Cruise Type:","detail":""], ["tag":"Cruise Start Date","detail":""], ["tag":"Visting Places:","detail":""], ["tag":"Number of  Adults:","detail":""], ["tag":"Number of Kids","detail":""], ["tag":"Cruise Price:","detail":""], ["tag":"Has Senior:","detail":""], ["tag":"Cruise Duration","detail":""], ["tag":"Cruise End Date","detail":""]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookings = db.selectBookingsByCustID(cid:cid)
        print(bookings)
    }

    let customerProfileIdentifier = "customerProfileIdentifier"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return bookings.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: customerProfileIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: customerProfileIdentifier)
        }
        let booking: BookingInfo
        booking = bookings[indexPath.row]
        
        let textLabel = "Booking ID: "  + String(booking.bid)
        
        cell?.textLabel?.text =  textLabel
        
        let cruiseTypeString = booking.bcruiseType
        let cruiseDurationString =  String(booking.bnightNum)
        let cruiseStartDateString = String(booking.bcruiseStartDate)
        
        let detailLabel = cruiseDurationString + "-Night " + cruiseTypeString + " on " + cruiseStartDateString
        
        cell?.detailTextLabel?.text = detailLabel
        
        let imageName = cruiseTypeString
        
        let originalImage = UIImage(named: imageName)
        
        
        // Resize Image
        let newSize = CGSize(width: 60, height:45)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        originalImage?.draw(in: CGRect(origin: .zero, size: newSize))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        cell?.imageView?.image = image
        
        return cell!
    }
    // Display booking details on Booking Details Screen when any of the table cells is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Pass the Booking ID to next screen
        let rowData = bookings[indexPath.row]
        let BookingID = rowData.bid
        
        // Define controller to bring to the Booking Details Screen
            let control = storyboard?.instantiateViewController(withIdentifier: "bookingPopUp") as! BookingDetailsViewController
        
            // Pass the info to Package Details Screen
            control.bookingIDResult = BookingID
           
        
            // Go to the  Package Details Screen
            present(control, animated: true)
            
        }
    
}

