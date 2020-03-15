//
//  TableViewController.swift
//  Task Tree
//
//  Created by Maksim Romanov on 15.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var task = Task(name: "", children: [])
    @IBAction func addTask(_ sender: Any) {
        addTaskAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") else { preconditionFailure("AlbumsCell cannot be dequeued") }
        cell.textLabel?.text = task.children[indexPath.row].name
        return cell
    }
    private func addTaskAlert() {
        let alert = UIAlertController(title: "Create new Task", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { [weak self] (_) in
            guard let textField = alert.textFields?[0],
                let taskName = textField.text else { return }
            let newTask = Task(name: taskName, children: [])
            self?.task.children.append(newTask)
            self?.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
