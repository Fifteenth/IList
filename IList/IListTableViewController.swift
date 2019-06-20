//
//  IListTableViewController
//  IList
//
//  Created by HengQiang Cao on 6/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit
import CoreData

class IListTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var taskArray = [Task]()
    
    @IBOutlet weak var buttonFilterOrClose: UIBarButtonItem!
    
    @IBOutlet weak var viewFilter: UIView!
    
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBAction func filter(_ sender: Any) {
        //viewHeader.isHidden = true
        tableRefresh()
        print(taskArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalData()
    }
    
    let cellWithIdentifier = "InfoCell"
    
    func tableRefresh() {
        tableView.reloadData()
    }
    
    func getLocalData() {
        
        let url = URL(string: "https://hengqc.com/infinity/PRRestService/rest/v1/getTask")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }

            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
            if let dictionary = json as? [String: Any] {
//                if let status = dictionary["Status"] as? String {
//                    print(status)
//                }
//                for (key, value) in dictionary {
//                    print("key:" + key)
//                }
                self.taskArray.removeAll()
                for anItem in dictionary["Data"] as! [Dictionary<String, AnyObject>] {
                    let task =  Task(uuid:(anItem["pyGUID"] as? String)!,
                                        id:(anItem["ID"] as? String)!,
                                        subject:(anItem["Subject"] as? String)!,
                                        desc:(anItem["Desc"] as? String)!
                                        )
                    self.taskArray.append(task)
                }
            }
        }
        task.resume()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellWithIdentifier, for: indexPath)

        // Configure the cell...
        let task = taskArray[indexPath.row]

        if let myCell = cell as? TableViewCellTask{
            //let id = task.id
            //let status = (task.status, "Open")
            myCell.GUID.text = task.id
            myCell.ID.text = task.id
            myCell.Subject.text = task.subject
            myCell.DES.text = task.desc
//            if(task.status == "Done"){
//                myCell.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 20)
//            }else{
//                myCell.backgroundColor = UIColor.white
//            }
            return myCell
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskArray[indexPath.row]
        let user = Task(
                        uuid:(task.uuid),
                        id:(task.id),
                        subject:(task.subject),
                        desc:(task.desc));
        performSegue(withIdentifier: "showTask", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTask",
            let viewDetail = segue.destination as? TaskViewController {
            viewDetail.task = sender as? Task
        }
    }
    
    
    
}
