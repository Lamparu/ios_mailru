//
//  LibraryTableViewCell.swift
//  BFY
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, containerView: UIView) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var containerView: UIView!
    var bookTitle: UILabel!
    var bookAuthor: UILabel!
    var bookImageView: UIImageView!
    
//    var containerViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(rgb: 0xbcc3b0)
        
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
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 1)
//
//        containerViewHeightConstraint.priority = UILayoutPriority.init(999)
//
//        containerViewHeightConstraint.isActive = true
    }
    
//    func createBookImageViewConstraint(label: UIImageView) {
//        
//    }
    
    func createBookTitleConstraint() {
        bookTitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bookTitle.centerYAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        bookTitle.widthAnchor.constraint(equalToConstant: 255).isActive = true
        bookTitle.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func createBookAuthorConstraint() {
        bookAuthor.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 30).isActive = true
        bookAuthor.widthAnchor.constraint(equalTo: bookTitle.widthAnchor).isActive = true
        bookAuthor.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
