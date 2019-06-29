//
//  ViewController.swift
//  Todoey
//
//  Created by yuchi.lee on 2019/6/29.
//  Copyright © 2019 Yuchi Lee. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    var itemArray = ["Moonbyul","Hyejin","Wheein"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK - Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add new item
    @IBAction func plusButtomTapped(_ sender: UIBarButtonItem) {
        
        var newItem = ""
        let alert = UIAlertController(title: "Do you want to add new items?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.itemArray.append(newItem)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new item"
            newItem = alertTextField.text!
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

