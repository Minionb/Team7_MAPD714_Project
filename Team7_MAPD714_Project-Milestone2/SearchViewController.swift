//
//  SearchViewController.swift
//  File Name: Team7_MAPD714_Project-Milestone2

//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 10/30/2023
//  Description: Search Cruises Screen

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let curisePackages = [
        ["ID" : "Bahamas1", "Cruise_Type" : "Bahamas Cruise","Visting_Places" : "Miami,Florida | Nassau,Bahamas | Ocean Cay MSC Marine Reserve,Bahamas | Maimi,Florida", "Cruise_Price" : 272, "duration" : 3, "Start_Date" :" 01/12/2024", "End_Date" : "01/15/2024"],
        ["ID":"Caribbean1", "Cruise_Type":"Caribbean Cruise","Visting_Places":"Miami, Florida | Puerto Plata, Dominican Republic", "Cruise_Price":200, "duration":2, "Start_Date":"01/15/2024", "End_Date":"01/17/2024"],
        ["ID":"Cuba1", "Cruise_Type":"Cuba Cruise","Visting_Places":"Orlando (Port Canaveral), Florida | Cozumel, Mexico | Orlando (Port Canaveral), Florida", "Cruise_Price":350, "duration":4, "Start_Date":"01/24/2024", "End_Date":"01/28/2024"],
        ["ID":"Sampler1", "Cruise_Type":"Sampler Cruise","Visting_Places":"ampa, Florida | Cozumel, Mexico | Tampa, Florida", "Cruise_Price":345, "duration":4, "Start_Date":"02/02/2024", "End_Date":"02/06/2024"] as [String : Any],
        ["ID":"Star1", "Cruise_Type":"Star Cruise","Visting_Places":"Singapore, Singapore | Penang, Malaysia | Singapore, Singapore", "Cruise_Price":285, "duration":3, "Start_Date":"01/30/2024", "End_Date":"02/02/2024"],
    ]
    
    let searchTableIdentifier = "SearchTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return curisePackages.count
      }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: searchTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: searchTableIdentifier)
        }
        
        let rowData = curisePackages[indexPath.row]
        
        let cruiseTypeString = String(describing: rowData["Cruise_Type"] ?? 0)
        let cruiseDurationString = String(describing: rowData["duration"] ?? 0)
        let cruiseHeader = cruiseDurationString + "-Night " + cruiseTypeString
        cell?.textLabel?.text =  cruiseHeader
        
        let price =  String(describing: rowData["Cruise_Price"] ?? 0)
        let priceString = "$" + price
        cell?.detailTextLabel?.text = priceString
        
        tableView.rowHeight = 70
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rowData = curisePackages[indexPath.row]
            let cruiseTypeString = String(describing: rowData["Cruise_Type"] ?? 0)
            let cruiseDurationString = String(describing: rowData["duration"] ?? 0)
            let cruiseHeader = cruiseDurationString + "-Night " + cruiseTypeString
            let message = "You selected " + cruiseHeader
        
            let control = storyboard?.instantiateViewController(withIdentifier: "packageDetails") as! PackageDetailsViewController
        
            present(control, animated: true)
            
        }
    
}
