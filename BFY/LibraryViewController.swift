//
//  LybraryViewController.swift
//  FlicksBox
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import UIKit

final class LibraryViewController: BooksTableViewController {

    private var books: [Book] = [.init(title: "Руслан и Людмила", author: "А.С. Пушкин", image: URL(string: ""))]

    let addBookButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupButtons()
        
        [tableView, addBookButton].forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func setupTableView() {
        books = BookManager.shared.loadBooks()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func setupButtons() {
//        addBookButton.addTarget(self, action: #selector(didTapAddBookButton), for: .touchUpInside)
        addBookButton.setTitle("Не нашли книгу?", for: .normal)
        addBookButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        addBookButton.setTitleColor(.black, for: .normal)
        addBookButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        createLibraryTableConstraint(tableView: tableView)
        createAddBookButtonConstraint(button: addBookButton)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        let book = books[indexPath.row]
                
        cell.configure(with: book)
//        let key = books[indexPath.row].key
//        cell.setupViews(he: CGFloat(key))

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return books.count
    }
    
    func createLibraryTableConstraint(tableView: UITableView) {
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    func createAddBookButtonConstraint(button: UIButton) {
        button.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        button.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
}
