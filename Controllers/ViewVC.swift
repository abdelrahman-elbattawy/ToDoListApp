//
//  ViewVC.swift
//  ToDoListApp
//
//  Created by Aboody on 14/08/2021.
//

import UIKit

class ViewVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    //MARK: - Constants
    static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    //MARK: - Vars
    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBarButtonItem()
    }
    
    //MARK: - Setup
    private func setupUI() {
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
    }
    
    private func setupBarButtonItem() {
        
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.didTapDelete))
        navigationItem.rightBarButtonItem = button
    }
    
    //MARK: - IBActions
    @objc private func didTapDelete() {
        
        guard let myItem = self.item else {
            return
        }
        
        ToDoListItem.realm.beginWrite()
        ToDoListItem.realm.delete(myItem)
        try! ToDoListItem.realm.commitWrite()
        deletionHandler?()
        
        navigationController?.popToRootViewController(animated: true)
    }
}
