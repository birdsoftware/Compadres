//
//  DirectoryTopVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/22/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class DirectoryTopVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var directoryTable: UITableView!
    
    var directoryDict:Array<Dictionary<String,String>> = [["title":"Body Shops"], ["title":"Mechanics"], ["title":"Tire & Wheel Shops"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        directoryTable.delegate = self
        directoryTable.dataSource = self
    }
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController //PTV
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension DirectoryTopVC {
    // #MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryDict.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt IndexPath: IndexPath) -> UITableViewCell {
        let cell: directoryTopCell = tableView.dequeueReusableCell(withIdentifier: "dirTopCell") as! directoryTopCell
        let thisMessage = directoryDict[IndexPath.row]
        cell.title.text = thisMessage["title"]
        cell.accessoryType = .disclosureIndicator // add arrow > to cell
        return cell
    }
}

extension DirectoryTopVC {
// #MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTopToLevel2" {
            let selectedRow = ((directoryTable.indexPathForSelectedRow as NSIndexPath?)?.row)! //returns int
            let data = directoryDict[selectedRow]
            if let vc = segue.destination as? DirectoryLevel2VC {
                vc.segueTitle = data["title"]
            }
        }
    }
}
