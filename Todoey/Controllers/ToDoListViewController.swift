//
//  ViewController.swift
//  Todoey
//
//  Created by Jake Garcia on 8/8/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArr = [Item]()
    
    let defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        loadItems()
        
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArr[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = (item.done ? .checkmark : .none)
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArr[indexPath.row]
        
        item.done = !item.done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            print(newItem)
            
            self.itemArr.append(newItem)
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving the context \(error)")
        }
        self.tableView.reloadData()
    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArr = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding the Items.plist")
//            }
//        }
//    }
    
}

