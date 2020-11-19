//
//  ViewController.swift
//  hitList(CoreData)
//
//  Created by Valeriia Zakharova on 19.11.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit
import CoreData

class HitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //NSManagedObject represents a single object stored in Core Data
    private var notes: [NSManagedObject] = []
    
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
                let noteToSave = textField.text else { return }
            
            self.save(text: noteToSave)
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
    
    private func save(text: String) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // insert a new managed object into a managed object context
        let managedContext = appdelegate.persistentContainer.viewContext
        
        // creates a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(text, forKey: "text")
        // save managedContext.save()
        do {
            try managedContext.save()
            notes.append(note)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension HitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = note.value(forKeyPath: "text") as? String
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
