//
//  AddTaskDelegate.swift
//  todolistapp
//
//  Created by Omar Ihmoda on 1/18/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit


protocol AddTaskDelegate: class {
    func itemSaved(by controller: AddViewController, title: String, detail: String, date: Date, index: NSIndexPath?, completed: Bool)
    func updateCompletion(completed: Bool, indexPath: NSIndexPath)
}
