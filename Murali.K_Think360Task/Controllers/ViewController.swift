//
//  ViewController.swift
//  Murali.K_Think360Task
//
//  Created by Murali on 5/24/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {
    
    //IBoutlet Declaration
    @IBOutlet var tableView: UITableView!
    
    //Variables Declaration
    var arrayOfImages = [String]()
    var arrayOfNames = [String]()
    var arrayOfDiscription = [String]()
    var arrayOfID = [Int]()
    var arrayOfQualification = [String]()
    

    var requestURL:URLRequest!
    var dataTask:URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromAPI()
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    //MARK:Fetching Data From API
    func fetchDataFromAPI()
    {
        
        let header = ["Authorization" : "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI3YTU2ZmQ3MS00ZTBlLTQ1ODYtOTk2MC01ZGM1NWVjNDhjODAiLCJzdWIiOiJjaGFuZHJhLnRoaW5rMzYwQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJjaGFuZHJhLnRoaW5rMzYwQGdtYWlsLmNvbSIsInVzZXJpZCI6ImNoYW5kcmEudGhpbmszNjBAZ21haWwuY29tIiwicGdpZCI6IjEiLCJleHAiOjE1NzE4MjcwNzgsImlzcyI6Imh0dHBzOi8vcWEyLnRlbGVkZW50aXguY29tIiwiYXVkIjoiaHR0cHM6Ly9xYTIudGVsZWRlbnRpeC5jb20ifQ.aFb5NAuN-tCPa8uhXmjjw5oYn8cZQ0ptIzppnsHlqac"]
        
        Alamofire.request("https://qa2.teledentix.com/api/networks/connections", headers: header).responseJSON { response in
            print(response)
            
            if let dataTask = response.result.value{
                
                var details:Dictionary = dataTask as! Dictionary<String, Any>
                
                var data = details["data"] as![String:Any]
                var connectionArray = data["connections"]as! [[String:Any]]
                
                for i in 0..<connectionArray.count
                {
                    if((connectionArray[i]["inviteeProvider"] as? NSNull) == nil)
                    {
                        var detailsArr = connectionArray[i]["inviteeProvider"] as! [String:Any]
                        self.arrayOfImages.append(detailsArr["photoId"]! as! String)
                        self.arrayOfNames.append(detailsArr["fullName"]! as! String)
                        self.arrayOfDiscription.append(connectionArray[i]["createdOn"]! as! String)
                        self.arrayOfQualification.append(detailsArr["title"]! as! String)
                        self.arrayOfID.append(connectionArray[i]["connectionId"]! as! Int)
                        
                        
                    }
                    else
                    {
                         print("null")
                    }
                }
                
                DispatchQueue.main.async {
                    print("loading")
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
}

//MARK:Extension for Tableview
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    //MARK: Number of Rows in a Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfNames.count
    }
    
    //MARK: Height for Row method in a Tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 170
    }
    
    //MARK: cell for Row method in a Tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        cell?.nameLabel.text = arrayOfNames[indexPath.row]
        
        cell?.descriptionLabel.text = arrayOfDiscription[indexPath.row]
        cell?.identityLabel.text = "\(arrayOfID[indexPath.row])"
        cell?.qualificationLabel.text = arrayOfQualification[indexPath.row]
        
        let url = URL(string: arrayOfImages[indexPath.row])
        cell?.imageLogo.sd_setImage(with: url, completed: { (response, error, type, url) in
            
        })
        
        cell?.moreButton.setImage(UIImage(named: "more"), for: .normal)
        cell?.videoCallButton.setImage(UIImage(named: "videocall"), for: .normal)
        
        
        return cell!
        
    }
}

