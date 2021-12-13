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
    let bookImageView: UIImageView = {
        let imageName = "bookImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        return imageView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(rgb: 0xfffcf4)
        
        setupContainerView()
        setupBookTitle()
        setupBookAuthor()
        setupBookImageView()
        
        [containerView, bookTitle, bookAuthor, bookImageView].forEach { self.addSubview($0) }
                
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(rgb: 0xbcc3b0)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBookTitle() {
        bookTitle.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
//        bookTitle.textColor = UIColor(rgb: 0x6A7F60)
        bookTitle.textColor = UIColor.black
        bookTitle.textAlignment = .left
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBookAuthor() {
        bookAuthor.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
//        bookAuthor.textColor = UIColor(rgb: 0x6A7F60)
        bookAuthor.textColor = UIColor.black
        bookAuthor.textAlignment = .left
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBookImageView() {
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.backgroundColor = UIColor.clear
        bookImageView.layer.borderWidth = 1
        bookImageView.layer.borderColor = UIColor.black.cgColor
        bookImageView.layer.cornerRadius = 4
        bookImageView.layer.masksToBounds = true
    }

    private func setupConstraints() {
        createContainerViewConstraint()
        createBookImageViewConstraint()
        createBookTitleConstraint()
//        createBookTitleConstraint(label: bookTitle, to: bookImageView)
        createBookAuthorConstraint()
//        createBookAuthorConstraint(label: bookAuthor, to: bookTitle)
    }
    
    func configure (with book: Book) {
        bookTitle.text = book.title
        bookAuthor.text = book.author
    }
    
    func createContainerViewConstraint() {
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 3
        containerView.layer.masksToBounds = false
    }
    
    func createBookImageViewConstraint() {
        bookImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        bookImageView.rightAnchor.constraint(equalTo: containerView.leftAnchor, constant: 60).isActive = true
        bookImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6).isActive = true
        bookImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    func createBookTitleConstraint() {
        bookTitle.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 15).isActive = true
        bookTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        bookTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        bookTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func createBookAuthorConstraint() {
        bookAuthor.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 15).isActive = true
        bookAuthor.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor).isActive = true
        bookAuthor.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
