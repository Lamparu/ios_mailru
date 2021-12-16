//
//  ResultsGridCell.swift
//  BFY
//
//  Created by Анастасия Московчук on 30.11.2021.
//

//import UIKit
//
//protocol ResultsTableViewDelegate: AnyObject {
//    func didSelectBook(book: BookInfo)
//}
//
//class ResultsTableCell: LibraryTableViewCell {
////    weak var delegate: ResultsTableViewDelegate?
//
////    private var addToLibrary: UIButton = UIButton()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        backgroundColor = UIColor(rgb: 0xfffcf4)
//        
//        setupContainerView()
//        setupBookTitle()
//        setupBookAuthor()
//        setupBookImageView()
////        setupAddToLibraryButton()
//        
//        [containerView, bookTitle, bookAuthor, bookImageView].forEach { self.addSubview($0) }
//                
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
////    func updateData(book: [BookInfo]) {
////        self.bookTitle =
////        self.bookAuthor =
////        self.bookImageView =
////        self.reloadData()
////    }
//    
////    private func setupAddToLibraryButton() {
////        addToLibrary.addTarget(self, action: #selector(didTapAddToLibraryButton), for: .touchUpInside)
////        addToLibrary.setImage(UIImage(named: "addNewBook.png"), for: .normal)
////        addToLibrary.translatesAutoresizingMaskIntoConstraints = false
////    }
//    
//    @objc private func didTapAddToLibraryButton(_ sender: UIButton) {
////        let AddNewBookViewController = AddNewBookViewController()
////        let navController = UINavigationController(rootViewController: AddNewBookViewController)
////        self.present(navController, animated: true, completion: nil)
////        self.navigationController?.pushViewController(AddNewBookViewController, animated: true)
//    }
//    
//    override func setupConstraints() {
//        createContainerViewConstraint()
//        createBookImageViewConstraint()
//        createBookTitleConstraint()
//        createBookAuthorConstraint()
////        createAddToLibraryConstraint()
//    }
//    
//    func createAddToLibraryConstraint() {
//        bookImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
//        bookImageView.rightAnchor.constraint(equalTo: containerView.leftAnchor, constant: 60).isActive = true
//        bookImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6).isActive = true
//        bookImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6).isActive = true
//    }
//}
