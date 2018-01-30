//
//  ViewController.swift
//  IRem
//
//  Created by HengQiang Cao on 10/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
