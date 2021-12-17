//
//  BooksTableViewController.swift
//  BFY
//
//  Created by Анастасия Московчук on 16.11.2021.
//
import UIKit

class BooksTableViewController: UIViewController {

//    var books: [Book] = [.init(title: "Гордость и предубеждение", author: "Джейн Остен", image: URL(string: ""))]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: "LibraryTableViewCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BooksTableViewController: UITableViewDelegate {

}

extension BooksTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
////        headerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        return headerView
//    }
}
