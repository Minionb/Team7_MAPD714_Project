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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sortingPicker: UIPickerView!
    
    // Define picker elements for sorting function
    private let sorting = [
         "Duration: Long to Short", "Duration: Short to Long", "Price: Low to High", "Price: High to Low"]
    
    // Define cruise packages dictionary list to store packages detail
    var cruisePackages = [
        ["ID" : "Bahamas1", "Cruise_Type" : "Bahamas Cruise","Visting_Places" : "Miami | Nassau,Bahamas ", "Cruise_Price" : 272, "duration" : 3, "Start_Date" : "01/12/2024", "End_Date" : "01/15/2024"],
        ["ID":"Caribbean1", "Cruise_Type":"Caribbean Cruise","Visting_Places":"Miami, Florida | Puerto Plata", "Cruise_Price":200, "duration":2, "Start_Date":"01/15/2024", "End_Date":"01/17/2024"],
        ["ID":"Cuba1", "Cruise_Type":"Cuba Cruise","Visting_Places":"Orlando | Cozumel, Mexico", "Cruise_Price":350, "duration":4, "Start_Date":"01/24/2024", "End_Date":"01/28/2024"],
        ["ID":"Sampler1", "Cruise_Type":"Sampler Cruise","Visting_Places":"ampa,Florida | Cozumel,Mexico", "Cruise_Price":345, "duration":4, "Start_Date":"02/02/2024", "End_Date":"02/06/2024"],
        ["ID":"Star1", "Cruise_Type":"Star Cruise","Visting_Places":"Singapore | Penang, Malaysia", "Cruise_Price":285, "duration":3, "Start_Date":"01/30/2024", "End_Date":"02/02/2024"],
    ]
    
    // Impletment filter button sorting function
    @IBAction func onFilterPressed(_ sender: UIButton) {
        
        let row = sortingPicker.selectedRow(inComponent: 0)
        let selectedFilter = sorting[row]
        
        // Sort the cruise packages by selected filter
        if (selectedFilter == "Duration: Long to Short"){
            let sortedArray = cruisePackages.sorted { ($0["duration"] as! Int) > ($1["duration"] as! Int) }
            cruisePackages = sortedArray
            // Reload the entire table view
            tableView.reloadData()
        }
        else if (selectedFilter == "Duration: Short to Long"){
            let sortedArray = cruisePackages.sorted { ($0["duration"] as! Int) < ($1["duration"] as! Int) }
            cruisePackages = sortedArray
            // Reload the entire table view
            tableView.reloadData()
        }
        else if (selectedFilter == "Price: Low to High"){
            let sortedArray = cruisePackages.sorted { ($0["Cruise_Price"] as! Int) < ($1["Cruise_Price"] as! Int) }
            cruisePackages = sortedArray
            // Reload the entire table view
            tableView.reloadData()
        }
        else if (selectedFilter == "Price: High to Low"){
            let sortedArray = cruisePackages.sorted { ($0["Cruise_Price"] as! Int) > ($1["Cruise_Price"] as! Int) }
            cruisePackages = sortedArray
            // Reload the entire table view
            tableView.reloadData()
        }
       
    }
    
    
    
    let searchTableIdentifier = "SearchTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortingPicker.dataSource = self
        sortingPicker.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return cruisePackages.count
      }
    
    // Implement table view elements
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: searchTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: searchTableIdentifier)
        }
        
        let rowData = cruisePackages[indexPath.row]
        
        let cruiseTypeString = String(describing: rowData["Cruise_Type"] ?? 0)
        let cruiseDurationString = String(describing: rowData["duration"] ?? 0)
        let cruiseStartDateString = String(describing: rowData["Start_Date"] ?? 0)

        let cruiseHeader = cruiseDurationString + "-Night " + cruiseTypeString + " on " + cruiseStartDateString
        
        cell?.textLabel?.text =  cruiseHeader
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        let price =  String(describing: rowData["Cruise_Price"] ?? 0)
        let priceString = "$" + price
        
        cell?.detailTextLabel?.text = priceString
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        tableView.rowHeight = 60
        
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
    
    // Displace cruise detail on Package Details Screen when any of the table cells is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Gather the cruise package details that will pass to next screen
            let rowData = cruisePackages[indexPath.row]
            let IDString = String(describing: rowData["ID"] ?? 0)
            let cruiseTypeString = String(describing: rowData["Cruise_Type"] ?? 0)
            let vistingPlaceString = String(describing: rowData["Visting_Places"] ?? 0)
            let cruisePriceString = String(describing: rowData["Cruise_Price"] ?? 0)
            let cruiseDurationString = String(describing: rowData["duration"] ?? 0)
            let cruiseStartDateString = String(describing: rowData["Start_Date"] ?? 0)
            let cruiseEndDateString = String(describing: rowData["End_Date"] ?? 0)


            // Define controller to bring to the Package Details Screen
            let control = storyboard?.instantiateViewController(withIdentifier: "packageDetails") as! PackageDetailsViewController
        
            // Pass the info to Package Details Screen
            control.IDResult = IDString
            control.cruiseTypeResult = cruiseTypeString
            control.vistingPlaceResult = vistingPlaceString
            control.cruisePriceResult = cruisePriceString
            control.cruiseDurationResult = cruiseDurationString
            control.cruiseStartDateResult = cruiseStartDateString
            control.cruiseEndDateResult = cruiseEndDateString
        
            // Go to the  Package Details Screen
            present(control, animated: true)
            
        }
    
}

// Picker Data Source Methods

extension SearchViewController: UIPickerViewDataSource{
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView,
                numberOfRowsInComponent component: Int) -> Int {
    return sorting.count
}
}

extension SearchViewController: UIPickerViewDelegate{
// MARK: Picker Delegate Methods
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return sorting[row]
}
}

