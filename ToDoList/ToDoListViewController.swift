//
//  ViewController.swift
//  ToDoList
//
//  Created by Hamza on 28/02/2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var myArray: [String] = [
    
        "new",
        "old",
        "after"
    ]
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: UserDetails.ToDoListArray) as? [String] {
            myArray = items
        }
        tableView.reloadData()
    }
    
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.myArray.append(textField.text ?? "\(String(describing: textField.placeholder))")
            self.defaults.setValue(self.myArray, forKey: UserDetails.ToDoListArray)
            self.tableView.reloadData()
            print(textField.text ?? "nil")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    

    //Mark - TableView Delegate Methods
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainTableViewCell, for: indexPath)
        cell.textLabel?.text = myArray[indexPath.row]
        return cell
    }
    
   
}

