//
//  AddViewController.swift
//  ToDoList
//
//  Created by Chucks Mac Book on 11/14/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var titleLabel: UITextField!
    var dp = Date()
    var descript: String?
    var lblTitle: String?
    
    var addDelegate: AddDelegate?
    var indexPath: NSIndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.date = dp
        desc.text = descript
        titleLabel.text = lblTitle
//        print("desc----------", String(describing: dp))
//        print("desc----------", descript!)
//        print("desc----------", lblTitle!)
//        print("desc----------", indexPath!.row)
        // Do any additional setup after loading the view.
    }


    @IBAction func addButtonPressed(_ sender: UIButton) {
//        print(titleLabel.text!, desc.text!, datePicker.date)
        if let index = indexPath {
        addDelegate?.AddToDoDetailsBy(by: self, title: titleLabel.text!, taskDesc: desc.text!, taskTime: datePicker.date, indexPath: index)
        } else {
            addDelegate?.AddToDoDetailsBy(by: self, title: titleLabel.text!, taskDesc: desc.text!, taskTime: datePicker.date, indexPath: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
