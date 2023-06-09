//
//  HomeContentView.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import UIKit

class HomeContentView: UIView {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: HomeContentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldView.layer.cornerRadius = 15
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        textField.borderStyle = .none
        textField.placeholder = "Add Book Name"
        addButton.layer.cornerRadius = 15
        
        tableView.separatorStyle = .none
        let hometableViewCellNib = UINib(nibName: HomeTableViewCell.nibName, bundle: nil)
        tableView.register(hometableViewCellNib, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)
    }
    
    @IBAction func addBook(_ sender: Any) {
//        guard let text = textField.text else {
//            return
//        }
//        if !text.isEmpty {
//            DummyDatabase.shared.addBook(withName: text)
//            textField.text = ""
//            tableView.reloadData()
//        }
        delegate?.addBook()
    }
}

