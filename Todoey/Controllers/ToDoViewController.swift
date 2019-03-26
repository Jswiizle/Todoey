//
//  ViewController.swift
//  Todoey
//
//  Created by macbookair on 3/21/19.
//  Copyright © 2019 Jeffrey Small. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {


    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        loadItems()

        

    }

    //MARK TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
//        if itemArray[indexPath.row].done == false {
//
//            itemArray[indexPath.row].done == true
//
//        }
//
//        else {
//
//            itemArray[indexPath.row].done == false
//
//        }
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Quit being a bitch", message: "Just do this shit", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           // What happens when user clicks add item button?
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextfield) in
            
            alertTextfield.placeholder = "Pussy"
            textField =  alertTextfield
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }
        catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
                
                itemArray = try decoder.decode([Item].self, from: data)
                
                
            }
            
            catch {
                
                print ("There was an error")
            }
            
            
        }
        
    }
    
}


