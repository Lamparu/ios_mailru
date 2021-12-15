//
//  ResultsGridView.swift
//  BFY
//
//  Created by Анастасия Московчук on 30.11.2021.
//

import UIKit

//protocol ResultsTableViewDelegate: AnyObject {
//    func didSelectBook(book: BookInfo)
//}

final class ResultsTableView: UIView {
//    weak var delegate: ResultsTableViewDelegate?
    
    private var books: [BookInfo] = []
    
    func updateData(books: [BookInfo]) {
        self.books = books
//            self.tableView.reloadData()
    }
    
    lazy var tableView: LibraryViewController = {
        
        
        
        return tableView
    }()
}
