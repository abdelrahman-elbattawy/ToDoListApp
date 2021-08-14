//
//  EntryVC.swift
//  ToDoListApp
//
//  Created by Aboody on 14/08/2021.
//

import UIKit

class EntryVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    //MARK: - Vars
    public var completionHandler: (() -> Void)?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
        setupTextField()
        setupBarButtonItem()
    }
    
    //MARK: - IBActions
    @objc func didTapSaveButton() {
        
        if let text = textField.text, !text.isEmpty {
            
            let date = datePicker.date
            
            ToDoListItem.realm.beginWrite()
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            ToDoListItem.realm.add(newItem)
            try! ToDoListItem.realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)

        } else {
            print("Add something")
        }
    }
    
    //MARK: - Setup
    private func setupTextField() {
        
        textField.becomeFirstResponder()
        textField.delegate = self
    }
    
    private func setupBarButtonItem() {
        
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.didTapSaveButton))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupDatePicker() {
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setDate(Date(), animated: true)
    }
}

extension EntryVC: UITextFieldDelegate {
    
    //MARK: - Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
