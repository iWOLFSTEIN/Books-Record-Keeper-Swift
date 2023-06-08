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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldView.layer.cornerRadius = 15
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        textField.borderStyle = .none
        textField.placeholder = "Add Book Name"
        addButton.layer.cornerRadius = 15
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let hometableViewCellNib = UINib(nibName: HomeTableViewCell.nibName, bundle: nil)
        tableView.register(hometableViewCellNib, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)
    }
    
    @IBAction func addBook(_ sender: Any) {
        guard let text = textField.text else {
            return
        }
        if !text.isEmpty {
            DummyDatabase.shared.addBook(withName: text)
            textField.text = ""
            tableView.reloadData()
        }
    }
}

extension HomeContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: 0))
        headerView.backgroundColor = .green
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension HomeContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DummyDatabase.shared.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reusableIdentifier, for: indexPath) as! HomeTableViewCell
        
        cell.delegate = self
        cell.title.text = DummyDatabase.shared.books[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension HomeContentView: HomeTableViewCellDelegate {
    func deleteButtonTapped(forCell cell: HomeTableViewCell) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            showAlert(from: viewController.self, withTitle: "Confirm", andSubtitle: "Are you sure you want to delete?", withCustomAction: {
                let text = cell.title.text
                DummyDatabase.shared.removeBook(withName: text!)
                self.tableView.reloadData()
            })
//        })
    }
}
