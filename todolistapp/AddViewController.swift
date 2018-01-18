//
//  AddViewController.swift
//  todolistapp
//
//  Created by Omar Ihmoda on 1/17/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    weak var delegate: AddTaskDelegate?
    
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailTextView.text = "Enter description here..."

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        let title = self.titleTextField.text!
        let detail = self.detailTextView.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let actual_date = self.datePicker.date
        let date = dateFormatter.string(from: actual_date)
        self.delegate?.itemSaved(by: self, title: title, detail: detail, date: actual_date, index: self.indexPath, completed: false)
    }
    

    
    
    
}
