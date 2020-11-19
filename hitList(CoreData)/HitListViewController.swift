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
    }
}

extension HitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}
