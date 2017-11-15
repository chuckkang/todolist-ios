//
//  AddDelegate.swift
//  ToDoList
//
//  Created by Chucks Mac Book on 11/14/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import Foundation
import UIKit

protocol AddDelegate {
    func AddToDoDetailsBy(by controller: AddViewController, title: String, taskDesc desc: String, taskTime time: Date, indexPath indexpath: NSIndexPath?)
}
