//
//  LybraryViewController.swift
//  FlicksBox
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import UIKit


class BooksViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(.init(nibName: "LibraryTableViewCell", bundle: nil), forCellReuseIdentifier: "LibraryTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BooksViewController: UITableViewDelegate {

}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell() // если не получится скастить ячейку типа LibraryTableViewCell, то вернет дефолтную UITableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}





final class LibraryViewController: BooksViewController {

    private var books: [Book] = [.init(title: "Руслан и Людмила", author: "А.С. Пушкин", image: URL(string: ""))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        let addBookButton = UIButton()
//        addBookButton.addTarget(self, action: #selector(didTapAddBookButton), for: .touchUpInside)
        addBookButton.setTitle("Не нашли книгу?", for: .normal)
        addBookButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        addBookButton.setTitleColor(.black, for: .normal)
        addBookButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(addBookButton)
        createAddBookButtonConstraint(button: addBookButton)

    }
    
//    @objc private func didTapAddBookButton(_ sender: UIButton) {
//        let MainBookVC = MainBookViewController()
//            let navController = UINavigationController(rootViewController: MainBookVC)
//            self.present(navController, animated: true, completion: nil)
//            self.navigationController?.pushViewController(MainBookVC, animated: true)
//    }

    func createAddBookButtonConstraint(button: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
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
    
}





//final class LybraryViewController123: UIViewController {
//
//    private let label: UILabel = {
//        let label = UILabel()
//        label.text = "ASLKDJLSAK"
//        label.backgroundColor = .gray
//        return label
//    }()
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.register(BooksViewCell.self, forCellReuseIdentifier: NSStringFromClass(BooksViewCell.self))
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .blue
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(label)
//        view.addSubview(tableView)
//
//        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 88).isActive = true
//
//        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
//        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        tableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//    }
//
//}
//
//extension LybraryViewController123: UITableViewDelegate {
//
//}
//
//extension LybraryViewController123: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BooksViewCell.self), for: indexPath) as! BooksViewCell
//        return cell
//    }
//}





