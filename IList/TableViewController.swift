//
//  TableViewController.swift
//  IList
//
//  Created by HengQiang Cao on 6/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var entity = [NSManagedObject]()
    
    @IBOutlet weak var buttonFilterOrClose: UIBarButtonItem!
    
    @IBOutlet weak var viewFilter: UIView!
    
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBAction func filter(_ sender: Any) {
        //viewFilter.isHidden = true
        viewHeader.isHidden = true
        //buttonFilterOrClose
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalData()
    }
    
    let cellWithIdentifier = "InfoCell"
    
    func getLocalData() {
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity1")
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                entity = results
                tableView.reloadData()
            }
        } catch  {
            fatalError("获取失败")
        }
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
        return entity.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellWithIdentifier, for: indexPath)

        // Configure the cell...
        let person = entity[indexPath.row]

        if let myCell = cell as? TableViewCell {
            let id = person.value(forKey: "id") as? String
            let status = (person.value(forKey: "status") ?? "Open") as? String
            myCell.labelID.text = id
            myCell.labelTitle.text = person.value(forKey: "title") as? String
            myCell.labelStatus.text = status
            
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            let myString = formatter.string(from: (person.value(forKey: "date") as? Date)!)
//            myCell.labelDate.text = myString
            
//            print(id)
            
            if(status == "Done"){
                myCell.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 20)
            }else{
                myCell.backgroundColor = UIColor.white
            }
            return myCell
        }

        return cell
    }
    
    
    class func insertData(user: User) {
        do {
            //        步骤一：获取总代理和托管对象总管
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            let inserInfo = NSEntityDescription.insertNewObject(forEntityName: "Entity1", into: managedObectContext);
            inserInfo.setValue(user.id,  forKey: "id");
            inserInfo.setValue(user.title, forKey: "title");
            inserInfo.setValue(user.detail, forKey: "detail");
            inserInfo.setValue(user.date, forKey: "date");
            try managedObectContext.save()
        } catch  {
            fatalError("Can't save")
        }
    }
    
    class func deleteData(id: String) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity1")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            let items = try managedObectContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                let itemID = item.value(forKey: "id") as! String
                if(itemID == id){
                    managedObectContext.delete(item)
                }
            }
            try managedObectContext.save()
        } catch  {
            fatalError("Can't save")
        }
    }
    
    class func updateData(user: User) {
        do {
            let userId = user.id
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity1")
//            let predicate = NSPredicate(format:"id=" + userId)
//            fetchRequest.predicate=predicate
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            let items = try managedObectContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                let itemID = item.value(forKey: "id") as! String
                if(itemID == userId){
                    item.setValue(user.title ,forKey: "title")
                    item.setValue(user.detail ,forKey: "detail")
                    item.setValue(user.status ,forKey: "status")
                    try managedObectContext.save()
                }
            }
        } catch  {
            fatalError("Can't save")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = entity[indexPath.row]
        let user = User(id:(person.value(forKey: "id") as? String)!,
                        title:(person.value(forKey: "title") as? String)!,
                        detail:(person.value(forKey: "detail") as? String)!,
                        date:(person.value(forKey: "date") as? Date)!,
                        status:"");
        performSegue(withIdentifier: "showDetail", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let viewDetail = segue.destination as? ViewDetailController {
            viewDetail.user = sender as? User
        }
    }

    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "detail", sender: sender)
    }
    
    
    
}
