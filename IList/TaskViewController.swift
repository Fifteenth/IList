//
//  ViewTaskController.swift
//  IList
//
//  Created by Cao HengQiang on 9/6/19.
//  Copyright © 2019 HengQiang Cao. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var txt_uuid: UITextField!
    
    @IBOutlet weak var txt_id: UITextField!
    @IBOutlet weak var txt_subject: UITextField!
    @IBOutlet weak var txt_desc: UITextField!

    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_uuid.text = task?.uuid
        txt_id.text = task?.id
        txt_subject.text = task?.subject
        txt_desc.text = task?.desc
    }
    
    
    @IBAction func taskDelete(_ sender: Any) {
        let parameters = ["pyGUID": txt_uuid.text as Any
            ] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://hengqc.com/infinity/PRRestService/task/v1/delete")! //change the url
        
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
    
    @IBAction func taskUpdate(_ sender: Any) {
        
        let parameters = [
            "pyGUID": txt_uuid.text as Any,
            "Subject" : txt_subject.text as Any,
            "Desc": txt_desc.text as Any
            ] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://hengqc.com/infinity/PRRestService/task/v1/update")! //change the url
        
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
    
}
