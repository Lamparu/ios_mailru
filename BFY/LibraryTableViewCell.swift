//
//  LibraryTableViewCell.swift
//  BFY
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    var containerView: UIView = UIView()
    var bookTitle: UILabel = UILabel()
    var bookAuthor: UILabel = UILabel()
    var bookImageView: UIImageView = UIImageView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(rgb: 0xfffcf4)
        
        setupContainerView()
        
        [containerView, bookTitle, bookAuthor, bookImageView].forEach { self.addSubview($0) }
                
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var containerViewHeightConstraint: NSLayoutConstraint!
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(rgb: 0xbcc3b0)
    }

    private func setupConstraints() {
        createContainerViewConstraint()
//        createBookImageViewConstraint(label: bookImageView)
        createBookTitleConstraint()
//        createBookTitleConstraint(label: bookTitle, to: bookImageView)
        createBookAuthorConstraint()
//        createBookAuthorConstraint(label: bookAuthor, to: bookTitle)
    }
    
    func configure (with book: Book) {
        bookTitle.text = book.title
        bookAuthor.text = book.author
    }
    
//    func setupViews(he: CGFloat) {
//        containerViewHeightConstraint.constant = he
//        }
    
    func createContainerViewConstraint() {
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 1)
//        containerViewHeightConstraint.priority = UILayoutPriority.init(999)
//        containerViewHeightConstraint.isActive = true
    }
    
//    func createBookImageViewConstraint(label: UIImageView) {
//        
//    }
    
    func createBookTitleConstraint() {
        bookTitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bookTitle.centerYAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        bookTitle.widthAnchor.constraint(equalToConstant: 255).isActive = true
        bookTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func createBookAuthorConstraint() {
        bookAuthor.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 10).isActive = true
        bookAuthor.widthAnchor.constraint(equalTo: bookTitle.widthAnchor).isActive = true
        bookAuthor.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
