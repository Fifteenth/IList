//
//  ViewController.swift
//  IList
//
//  Created by HengQiang Cao on 10/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        var userId = ""
        // Do any additional setup after loading the view.
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity1")
            let sort = NSSortDescriptor(key: #keyPath(Entity1.id), ascending: false)
            fetchRequest.sortDescriptors = [sort]
            fetchRequest.fetchLimit = 1
            //            let predicate = NSPredicate(format:"id=" + userId)
            //            fetchRequest.predicate=predicate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            let items = try managedObectContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                let itemID = item.value(forKey: "id") as! String
                userId = itemID
            }
        } catch  {
            fatalError("Get last record failed!")
        }
        var num = Int(userId) ?? 0
        num = num + 1
        
        if(num < 10){
            textID?.text = "00" + String(num)
        }
        else if(num > 10 && num < 100){
            textID?.text = "0" + String(num)
        }else{
            textID?.text = String(num)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var textID: UITextField!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDetail: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func saveAction(_ sender: Any) {
        let user = User(id:textID.text ?? "",
                        title:textName.text ?? "",
                        detail:textDetail.text ?? "",
                        date:datePicker.date,
                        status:"Open");
        TableViewController.insertData(user: user)
        self.navigationController?.popViewController(animated: true)
    }
    
}
