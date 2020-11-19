//
//  ViewController.swift
//  hitList(CoreData)
//
//  Created by Valeriia Zakharova on 19.11.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class HitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @IBAction func addName(_ sender: UIBarButtonItem) {
        // creates an alert
        let alert = UIAlertController(title: "New Note", message: "Add your new note here", preferredStyle: .alert)
        
        //creates save button, textField in which we can type our new note
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let textField = alert.textFields?.first,
                let notToSave = textField.text else { return }
            
            self.names.append(notToSave)
            self.tableView.reloadData()
        }
        
        // creates cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // adds textField to the alert
        alert.addTextField()
        
        //adds action buttons to the alert
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //shows the alert
        present(alert, animated: true)
    }
}

extension HitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
