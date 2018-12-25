//
//  ViewDetailControllerViewController.swift
//  IList
//
//  Created by HengQiang Cao on 13/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit

class ViewDetailController: UIViewController, UITextViewDelegate  {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        labelID.text = user?.id
        labelTitle.text = user?.title
        labelDetail.text = user?.detail
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: (user?.date)!)
        labelDate.text = myString
        labelDate.textAlignment = .right
        
        labelDetail.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewDetailController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewDetailController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if (labelDetail.isFirstResponder && self.view.frame.origin.y == 0){
            self.view.frame.origin.y -= 200
        }
    }
    
    func textViewDidEndEditing(_ textField: UITextView){
       
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (labelDetail.isFirstResponder && self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (labelDetail.isFirstResponder && self.view.frame.origin.y != 0){
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var labelID: UILabel!
    //@IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTitle: UITextField!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDetail: UITextView!
    
    
    
    @IBAction func deleteAction(_ sender: Any) {
        let deleteId = labelID.text;
        TableViewController.deleteData(id: deleteId!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateData(_ sender: Any) {
        let user = User(id:labelID.text ?? "",
                        title:labelTitle.text ?? "",
                        detail:labelDetail.text ?? "",
                        date: NSDate() as Date,
                        status:"Open");
        TableViewController.updateData(user:user)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneData(_ sender: Any) {
        let user = User(id:labelID.text ?? "",
                        title:labelTitle.text ?? "",
                        detail:labelDetail.text ?? "",
                        date: NSDate() as Date,
                        status:"Done");
        TableViewController.updateData(user:user)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
