//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Aboody on 14/08/2021.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Constants
    private let cellName = "Cell"
    
    //MARK: - Vars
    private var data = [ToDoListItem]()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = ToDoListItem.realm.objects(ToDoListItem.self).map({ $0 })
        setupTableView()
    }
    
    //MARK: - IBActions
    @IBAction func didTapAddButton() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryVC else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Setup
    private func setupTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Helpers Functions
    private func refresh() {
        
        data = ToDoListItem.realm.objects(ToDoListItem.self).map({ $0 })
        tableView.reloadData()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewVC else {
            return
        }
        
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        navigationController?.pushViewController(vc, animated: true)
    }
}
