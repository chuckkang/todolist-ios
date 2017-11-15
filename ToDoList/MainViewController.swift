//
//  ViewController.swift
//  ToDoList
//
//  Created by Chucks Mac Book on 11/14/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UITableViewController{
    var arrTasks = [ToDoList]()
    var arrTest = ["Chuck", "Patrick", "Elva", "Keith", "chris"]
    let dbObject = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       // print("ok")
        performSegue(withIdentifier: "AddSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination, "this is the segue")
        // this is used when you want to pass data to the view that you're going to.
        if segue.identifier == "AddSegue" {
            // create the instance of the controller.
            if sender is NSIndexPath {
                // if this type is an SNIndexPath then it is an EDIT
                // we need to findout the NSINdexPath that was sent here from the performsegue.
                // then create and cast the controller that we will go to from the segue.destination.
                // then, with the instance of the addviewcontroller, get the delegate so that
                // we can use the functions and data from the newly created controller.
                let indexPath = sender as! NSIndexPath

                let addVC = segue.destination as! AddViewController
                //from this controller get the delegate and set it up as the instance of teh THIS view controller.
                
                //print(addVC.titleLabel, "addVC.titleLabel")
                addVC.lblTitle = arrTasks[indexPath.row].title!
//                    print(arrTasks[indexPath.row].title!)
                addVC.descript = arrTasks[indexPath.row].desc!
//                    print(arrTasks[indexPath.row].desc!)
                addVC.dp = (arrTasks[indexPath.row].dueDate)!
//                    print(arrTasks[indexPath.row].dueDate!)
                addVC.indexPath = indexPath
                 // you need to do this for sure.....this will set up the delegate
                // without this, this controller will not know where to get the data from.
                addVC.addDelegate = self
                
            } else {
                // this is the new ADD...
                let addVC =  segue.destination as! AddViewController
                addVC.addDelegate = self
            }
        }
    }

    func loadData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        do {
            let result = try dbObject.fetch(request)
            arrTasks = result as! [ToDoList]
        } catch {
            print("\(error)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MainViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
//        print("cell \(indexPath.row)")
        cell.titleLabel.text = arrTasks[indexPath.row].title
        cell.descriptionLabel.text = arrTasks[indexPath.row].desc
        cell.dateLabel.text = String(describing: arrTasks[indexPath.row].dueDate!)
        //cell.dateLabel.text = "date string"
        return cell
    }
    ///////// EDIT FUNCTION ///////////
    /// need to select the row and get the indexPath.row.
    /// get the data from teh array based on the on the indexPath
    /// set the values for the labels
    /// perform a segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddSegue", sender: indexPath)
    }
    //////// DELETE FUNCTION
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /// get the todotask that is an object
        let task = arrTasks[indexPath.row]
        dbObject.delete(task)
        do {
            try dbObject.save()
        } catch {
            print("error \(error)")
        }
        arrTasks.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension MainViewController: AddDelegate {
    func AddToDoDetailsBy(by controller: AddViewController, title: String, taskDesc desc: String, taskTime time: Date, indexPath indexpath: NSIndexPath?){
//            print(title, desc, time, "******************************")
//        print(controller, "THIS IS THE CONTROLLER")

        if let index = indexpath {
            // this is an edit....so update the array at the index location
            arrTasks[index.row].title = title
            arrTasks[index.row].desc = desc
            arrTasks[index.row].dueDate = time
        } else {
        let task = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: dbObject) as! ToDoList
        task.title = title
        task.desc = desc
        task.dueDate = time
        arrTasks.append(task)
//        print(arrTasks)
        
        }
        controller.dismiss(animated: true, completion: nil)
        tableView.reloadData()
        do {
            try dbObject.save()
        } catch {
            print("error \(error)")
        }
    }
}

