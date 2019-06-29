//
//  ViewTaskController.swift
//  IList
//
//  Created by Cao HengQiang on 9/6/19.
//  Copyright © 2019 HengQiang Cao. All rights reserved.
//

import UIKit

class TaskAddController: UIViewController {
    
    //@IBOutlet weak var txt_id: UITextField!
    
    @IBOutlet weak var txt_Subject: UITextField!
 
    @IBOutlet weak var txt_desc: UITextView!
    
    @IBAction func taskSave(_ sender: Any) {
        print("123456")
        
        let id = ""
        let subject = txt_Subject.text ?? ""
        let desc = txt_desc.text ?? ""
        
        let parameters = ["ID": id,
                          "Subject" : subject,
                          "Desc": desc
                          ] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://www.hengqc.com/infinity/PRRestService/task/v1/add")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
