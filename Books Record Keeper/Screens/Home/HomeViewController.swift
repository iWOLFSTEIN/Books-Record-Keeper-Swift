//
//  HomeViewController.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var contentView: HomeContentView!
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
    }
}

extension HomeViewController: UITableViewDelegate {
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

extension HomeViewController: UITableViewDataSource {
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


extension HomeViewController: HomeTableViewCellDelegate {
    func deleteButtonTapped(forCell cell: HomeTableViewCell) {
        showAlert(from: self, withTitle: "Confirm", andSubtitle: "Are you sure you want to delete?", withCustomAction: {
            let text = cell.title.text
            DummyDatabase.shared.removeBook(withName: text!)
            self.contentView.tableView.reloadData()
        })
    }
}

extension HomeViewController: HomeContentViewDelegate {
    func addBook() {
        guard let text = contentView.textField.text else {
            return
        }
        if !text.isEmpty {
            viewModel.createRecord(withName: text, inEntity: .books)
            contentView.textField.text = ""
        }
        
        var records: [Book] = self.viewModel.retrieveAllBooksRecords()
        print(records)
    }
}
