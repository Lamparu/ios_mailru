//
//  ResultsGridView.swift
//  BFY
//
//  Created by Анастасия Московчук on 30.11.2021.
//

import UIKit
//import Botticelli

protocol ResultsGridViewDelegate: AnyObject {
//    func didSelectAuthor(author: Author)
//    func didSelectTitle(title: Title)
}

final class ResultsGridView: UIView {
    weak var delegate: ResultsGridViewDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag

//        tableView.register(ResultsGridView.self,
//            forCellWithReuseIdentifier: "ResultsGridView"
//        )
//
        return tableView
    }()

//    init(frame: CGRect) {
//        super.init()
//        configureSubviews()
//    }

//    private func configureSubviews() {
//        collectionView.frame = bounds
//        addSubview(collectionView)
//    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

//    func updateData(author: [Author], title: [Title]) {
//        self.author = author
//        self.title = title
//        self.collectionView.reloadData()
//    }
}
