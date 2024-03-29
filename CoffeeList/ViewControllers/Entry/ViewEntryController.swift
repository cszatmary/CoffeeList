//
//  ViewEntryController.swift
//  CoffeeList
//
//  Created by Christopher Szatmary on 2016-06-24.
//  Copyright © 2016 SzatmaryInc. All rights reserved.
//

import UIKit

class ViewEntryController: UIViewController {
    
    // *** Views *** //
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .gray
        label.cornerRadius = 10
        label.font = label.font.withSize(20)
        return label
    }()
    
    let coffeeTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .gray
        label.cornerRadius = 10
        label.font = label.font.withSize(20)
        return label
    }()
    
    let favCoffeeShopLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .gray
        label.cornerRadius = 10
        label.font = label.font.withSize(20)
        return label
    }()
    
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.isEditable = false
        textView.setBorder(width: 2, color: .gray)
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    func generateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.cornerRadius = 10
        label.font = label.font.withSize(20)
        return label
    }
    // *** End Views *** //
    
    var entry: Entry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditEntry))
        view.backgroundColor = .white
        setupView()
        loadEntry()
    }
    
    ///Will load the selected entry
    func loadEntry() {
        nameLabel.text = entry.name
        coffeeTypeLabel.text = entry.coffeeType
        favCoffeeShopLabel.text = entry.favCoffeeShop
        notesTextView.text = entry.notes
    }
    
    ///Called when the user touches the edit button
    @objc func handleEditEntry() {
        let viewController = EditEntryController()
        viewController.entry = entry
        viewController.delegate = self
        navigationController?.present(viewController: viewController, animationType: .fade)
    }
}

extension ViewEntryController: EntryDelegate {
    ///Notifies the ViewController to update the displayed values for the entry.
    func update(newValue: Entry) {
        entry = newValue
        loadEntry()
        (navigationController?.viewControllers[0] as! ManageEntriesController).update(newValue: newValue)
    }
}

// MARK: - Setup views and constraints.
extension ViewEntryController {
    func setupView() {
        let topOffset = view.height / 16
        // nameLabel
        view.addSubview(nameLabel)
        nameLabel.centerX(to: view)
        nameLabel.top(to: view, offset: navigationController!.navigationBar.height + 30)
        nameLabel.width(to: view, offset: -20)
        nameLabel.height(to: view, multiplier: 1/10)
        
        // coffeeTypeLabel
        view.addSubview(coffeeTypeLabel)
        coffeeTypeLabel.centerX(to: view)
        coffeeTypeLabel.topToBottom(of: nameLabel, offset: topOffset)
        coffeeTypeLabel.width(to: nameLabel)
        coffeeTypeLabel.height(to: nameLabel)
        
        // favCoffeeShopLabel
        view.addSubview(favCoffeeShopLabel)
        favCoffeeShopLabel.centerX(to: view)
        favCoffeeShopLabel.topToBottom(of: coffeeTypeLabel, offset: topOffset)
        favCoffeeShopLabel.width(to: nameLabel)
        favCoffeeShopLabel.height(to: nameLabel)
        
        // notesTextView
        view.addSubview(notesTextView)
        notesTextView.centerX(to: view)
        notesTextView.topToBottom(of: favCoffeeShopLabel, offset: topOffset)
        notesTextView.width(to: nameLabel)
        //        notesTextView.height(to: nameLabel, multiplier: 2)
        notesTextView.bottom(to: view, offset: -30)
    }
}
