//
//  ViewController.swift
//  Todoey
//
//  Created by yuchi.lee on 2019/6/29.
//  Copyright © 2019 Yuchi Lee. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
//        let newItem = Item()
//        newItem.title = "MoonByul"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Hwasa"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Wheein"
//        itemArray.append(newItem3)
        
        
        loadItems()
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//        }
        // Do any additional setup after loading the view.
    }
    
    // MARK - Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add new item
    @IBAction func plusButtomTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Do you want to add new items?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "new item"
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("error encoding item array \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error in decoding \(error)")
            }
            
        }
        
        
    }
}

