//
//  ViewController.swift
//  WhatToDo
//
//  Created by milind shelat on 23/01/20.
//  Copyright © 2020 milind shelat. All rights reserved.
//

import UIKit

class WhatToDoVC: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newitem = Item()
        newitem.title = "Eat"
        itemArray.append(newitem)
        
        let newitem2 = Item()
        newitem2.title = "Sleep"
        itemArray.append(newitem2)
        
        let newitem3 = Item()
        newitem3.title = "Fill in"
        itemArray.append(newitem3)
        
        let newitem4 = Item()
        newitem4.title = "Repeat"
        itemArray.append(newitem4)
        
        if let items = defaults.array(forKey: "ToDoitemsArray") as? [Item] {
            itemArray = items
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "What do you have to do??", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            let newitem = Item()
            newitem.title = textfield.text!
            
            self.itemArray.append(newitem)
            self.defaults.set(self.itemArray, forKey: "ToDoitemsArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
           alertTextField.placeholder = "Enter New Item"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

