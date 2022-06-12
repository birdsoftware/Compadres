//
//  MessagesVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/18/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //table view
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messagesDict:Array<Dictionary<String,String>> = [["isRead":"N","from":"System","message":"Payment Made! Thank you", "date":"10:31 AM","detail":"Your payment of $96.15 has successfully been processed."],
                        ["isRead":"Y","from":"Compadres Support", "message":"Bring your car in and we can help fix it", "date":"9:46 AM","detail":"test details 1"],
                        ["isRead":"Y","from":"Compadres", "message":"Know someone who needs a car? Refer them to us and you will get $200!", "date":"Yesterday","detail":"test details 2"],
                        ["isRead":"N","from":"Service Alert", "message":"Your next oil change is due on July 15, 2017", "date":"5/15/2017", "detail":"test details 3"],
                        ["isRead":"Y","from":"Tow Request", "message":"Your Tow Request has been sent and will arrive in approximately 23 minutes.", "date":"2/3/2017", "detail":"test details 4"],
                        ["isRead":"N","from":"Compadres", "message":"Know someone who needs a car? Refer them to us and you will get $200!", "date":"1/13/2017","detail":"test details 5"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegate
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        // Table ROW Height set to auto layout
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        messagesTableView.estimatedRowHeight = 100
    }
    @IBAction func newMessageButtonAction(_ sender: Any) {
        
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension MessagesVC{
    // #MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesDict.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt IndexPath: IndexPath) -> UITableViewCell {
        let cell: messagesTVC = tableView.dequeueReusableCell(withIdentifier: "messagesCell") as! messagesTVC
        let thisMessage = messagesDict[IndexPath.row]
        if thisMessage["isRead"] == "Y" {
            cell.blueImage.isHidden = true
        }
        cell.title.text = thisMessage["from"]
        cell.message.text = thisMessage["message"]
        cell.dateTime.text = thisMessage["date"]
        cell.accessoryType = .disclosureIndicator // add arrow > to cell
        
        return cell
    }
    
}

extension MessagesVC{
    // #MARK: - segue
    func segueDB(){//GO BACK
        self.performSegue(withIdentifier: "segueMessages2ToDashboard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMessageToMessageDetail" {
            
            let selectedRow = ((messagesTableView.indexPathForSelectedRow as NSIndexPath?)?.row)! //returns int
            let data = messagesDict[selectedRow]
            
            if let vc = segue.destination as? AmessageVC {
                
                vc.segueFrom = data["from"]
                vc.segueMessage = data["message"]
                vc.segueDate = data["date"]
                vc.segueMessageDetails = data["detail"]
            }
        }
        if segue.identifier == "segueMessageToCompose" {
            if let vc = segue.destination as? CompseMessageVC {
                vc.segueHead = "fromMessages"//segueDetailToCompose
            }
        }
    }
}
