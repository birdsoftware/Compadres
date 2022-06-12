//
//  DirectoryLevel2VC.swift
//  Compadres
//
//  Created by Brian Bird on 8/22/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class DirectoryLevel2VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var bodyDict:Array<Dictionary<String,String>> = [
        ["title":"Carl's Body Shop","detail":"Carl's Body Shop is a dependable auto body parts store in Las Vegas.","location":"3480 Spring Mountain Rd, Las Vegas, NV 89102","phone":"(702) 367-1706"],
        ["title":"Company Name 1","detail":"Bodywork, Tires and More","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"],
        ["title":"Company Name 2","detail":"Paint, Leather and More.","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"]]
    
    var mechDict:Array<Dictionary<String,String>> = [
        ["title":"Jim's Full Mechanic Shop","detail":"Auto engine repaire","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"],
        ["title":"Total Transmission","detail":"Transmission Repair and More","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"],
        ["title":"AAA Mufflers","detail":"Total Muffler Repair.","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"]]
    
    var tireDict:Array<Dictionary<String,String>> = [
        ["title":"William's Complete Tire Shop","detail":"Custom rims and detailing.","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"],
        ["title":"Best Tires","detail":"Some details here 1","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"],
        ["title":"The Wheel Shop","detail":"Some more details 2","location":"333 S Decatur Blvd, Las Vegas, NV","phone":"(702) 111-2222"]]
    
    var selectedDict = Array<Dictionary<String,String>>()//[["title":"","detail":""]]
    
    //segue Data
    var segueTitle:String!
    
    @IBOutlet weak var directoryTable: UITableView!
    @IBOutlet weak var titleThisView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectDataFromSegueString()
        titleThisView.text = segueTitle
        // Delegate
        directoryTable.delegate = self
        directoryTable.dataSource = self
        // Table ROW Height set to auto layout
        directoryTable.rowHeight = UITableViewAutomaticDimension
        directoryTable.estimatedRowHeight = 100
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension DirectoryLevel2VC {
    // #MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDict.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt IndexPath: IndexPath) -> UITableViewCell {
        let cell: directoryLevel2Cell = tableView.dequeueReusableCell(withIdentifier: "dirLevel2Cell") as! directoryLevel2Cell
        let data = selectedDict[IndexPath.row]
        cell.title.text = data["title"]
        cell.detail.text = "\(data["detail"]!), \(data["location"]!)"
        cell.accessoryType = .disclosureIndicator // add arrow > to cell
        return cell
    }
    
    func selectDataFromSegueString() {
        switch segueTitle {
        case "Body Shops":
            selectedDict = bodyDict
        case "Mechanics":
            selectedDict = mechDict
        case "Tire & Wheel Shops":
            selectedDict = tireDict
        default:
            return
        }
    }
}

extension DirectoryLevel2VC{
    // #MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLevel2ToBottum" {
            let selectedRow = ((directoryTable.indexPathForSelectedRow as NSIndexPath?)?.row)! //returns int
            if let vc = segue.destination as? DirectoryBottumVC {
                vc.segueTitles = segueTitle
                vc.selectedDic = selectedDict[selectedRow]
            }
        }
    }
}
