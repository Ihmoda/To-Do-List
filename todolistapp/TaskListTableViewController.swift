//
//  TaskListTableViewController.swift
//  todolistapp
//
//  Created by Omar Ihmoda on 1/17/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, AddTaskDelegate {

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var task_list: [TaskItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAll()
        print(self.task_list)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.task_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        cell.titleLabel.text = self.task_list[indexPath.row].title!
        cell.detailLabel.text = self.task_list[indexPath.row].detail!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let actual_date = self.task_list[indexPath.row].date!
        let date = dateFormatter.string(from: actual_date)
        cell.dateLabel.text = date
        
        if  self.task_list[indexPath.row].completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        
        if !self.task_list[indexPath.row].completed {
            cell.accessoryType = .checkmark
            self.task_list[indexPath.row].completed = true
            self.updateCompletion(completed: true, indexPath: indexPath as! NSIndexPath)
        } else {
            cell.accessoryType = .none
            self.task_list[indexPath.row].completed = false
            self.updateCompletion(completed: false, indexPath: indexPath as NSIndexPath)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddViewController
        destination.delegate = self
    }
    
    func updateCompletion(completed: Bool, indexPath: NSIndexPath) {
        self.task_list[indexPath.row].completed = completed
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }

    
    func itemSaved(by controller: AddViewController, title: String, detail: String, date: Date, index: NSIndexPath?, completed: Bool) {
        
        if let ip = index {
            //update functionality
            task_list[ip.row].title! = title
            task_list[ip.row].detail! = detail
            task_list[ip.row].date! = date
        } else {
            //add functionality
            print("Received \(title) task from addview")
        
            let new_task = TaskItem(context: self.context)
            new_task.title = title
            new_task.detail = detail
            new_task.date = date
            task_list.append(new_task)
        }
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }

    
    func fetchAll(){
        
        let request:NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        do {
            let result = try context.fetch(request)
            self.task_list = result as! [TaskItem]
        } catch {
            print(error)
        }
    
    }
    
}
