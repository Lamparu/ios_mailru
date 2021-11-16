//
//  BooksTableViewController.swift
//  BFY
//
//  Created by Анастасия Московчук on 16.11.2021.
//

import UIKit

class BooksTableViewController: UIViewController {

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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell() // если не получится скастить ячейку типа LibraryTableViewCell, то вернет дефолтную UITableViewCell
        }
        return cell
    }
}


