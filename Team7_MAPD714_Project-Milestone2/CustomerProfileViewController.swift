//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/27/2023
//  Description: Customer Profile Screen

import UIKit
import SQLite3

class CustomerProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // Pass from Login Screen
    var cid : Int = 1
    var customerEmail: String = ""
    
    var db = BookingInfoDBManager()
    var bookings = Array<BookingInfo>()
  
    
    var bookingDetails = [ ["tag":"Booking ID:","detail":""], ["tag":"Cruise Type:","detail":""], ["tag":"Cruise Start Date","detail":""], ["tag":"Visting Places:","detail":""], ["tag":"Number of  Adults:","detail":""], ["tag":"Number of Kids","detail":""], ["tag":"Cruise Price:","detail":""], ["tag":"Has Senior:","detail":""], ["tag":"Cruise Duration","detail":""], ["tag":"Cruise End Date","detail":""]]
    
    @IBOutlet weak var tempFullNameLabel: UILabel!
    @IBOutlet weak var tempAddressLabel: UILabel!
    @IBOutlet weak var tempCandCLabel: UILabel!
    @IBOutlet weak var tempPhoneNumLabel: UILabel!
    @IBOutlet weak var tempEmailLabel: UILabel!
    @IBOutlet weak var tempPasswordLabel: UILabel!
    
    // CustomerInfo database test code
    var dbCusts = CustomerInfoDBManager()
    var customer: CustomerInfo?
    //var custs = Array<CustomerInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customer = dbCusts.getCustomerByEmail(cemail: customerEmail)
        
        tempFullNameLabel.text = customer!.cfirstname + " " + customer!.clastname
        
        tempAddressLabel.text = customer!.caddress
        
        tempCandCLabel.text = customer!.ccity + ", " + customer!.ccountry
        
        tempPhoneNumLabel.text = customer!.ctelephone
        
        tempEmailLabel.text = customer!.cemail
        
        tempPasswordLabel.text = customer!.cpassword
        
        bookings = db.selectBookingsByCustID(cid:customer!.cid)
        
        cid = customer!.cid
        print(customer!.cid)
        print(bookings)
    }
    
    
    @IBAction func editProfileButttonClicked(_ sender: Any) {
        
        let control = storyboard?.instantiateViewController(withIdentifier: "profileEdit") as! EditCustomerProfileController
        
        control.customerEmail = customer!.cemail
        control.customerPassword = customer!.cpassword
        
        present(control, animated: true)
    }
    
    @IBAction func bookCruiseButtonClicked(_ sender: UIButton) {
        
        let control = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        control.cid = cid
        control.customerEmail = customerEmail
        
        present(control, animated: true)
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
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 10)
        
        let cruiseTypeString = booking.bcruiseType
        let cruiseDurationString =  String(booking.bnightNum)
        let cruiseStartDateString = String(booking.bcruiseStartDate)
        
        let detailLabel = cruiseDurationString + "-Night " + cruiseTypeString + " on " + cruiseStartDateString
        
        cell?.detailTextLabel?.text = detailLabel
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 10)
        
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

