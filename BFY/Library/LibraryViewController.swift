//
//  LybraryViewController.swift
//  FlicksBox
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import CryptoKit

var books = [BookInfo]()
var isSearching: Bool = false
var booksInLibrary = [BookInfo]()

class LibraryViewController: BooksTableViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    
    let searchBookBar = SearchBarView()
    private let searchModel = SearchModel()
    private lazy var searchBar: UISearchBar = {
        let searchBar = searchBookBar.searchBar
        searchBar.delegate = self
        return searchBar
    }()
    
    let addBookButton = UIButton()
    let addBookLabel1 = UILabel()
    let addBookLabel2 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBookBar.searchBar.delegate = self
        searchBookBar.searchBar.showsCancelButton = true

        setupUI()
        
        [searchBookBar, tableView, addBookButton, addBookLabel1, addBookLabel2].forEach { view.addSubview($0) }
        
        initBooks()
                
        configureGestures()
        
        setupConstraints()
        
        initializeHideKeyboard()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        if isSearching == false {
            let book = books[indexPath.row]
            cell.configure(with: book)
        }
        if isSearching == true {
            let book = booksInLibrary[indexPath.row]
            cell.configure(with: book)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == false {
            return books.count
        }
        return booksInLibrary.count
    }
    
    func addBookFirebase(book: BookInfo) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(userID).updateData(["library." + book.id : "0"])
        db.collection("Books").document(book.id).setData(["title": book.title,
                                                             "authors": makeStringAuthors(authors: book.authors ?? ["Автор"]),
                                                          "image" : book.image ?? "BookCover"])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == false {
            let book = books[indexPath.row]
            updateLastBookDB(bookID: book.id)
        }
        if isSearching == true {
            let book = booksInLibrary[indexPath.row]
            addBookFirebase(book: book)
            updateLastBookDB(bookID: book.id)
        }
        isSearching = false
        let destination = TabBarController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc private func didTapAddBookButton(_ sender: UIButton) {
        let AddNewBookViewController = AddNewBookViewController()
        let navController = UINavigationController(rootViewController: AddNewBookViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        searchBookBar.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBookBar.searchBar.resignFirstResponder()
        searchBookBar.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func splitAuthors(authors: String) -> [String] {
        let listAuthors = authors.split{$0 == ","}.map(String.init)
        let trimmedAuthors = listAuthors.map { $0.trimmingCharacters(in: .whitespaces) }
        return trimmedAuthors
    }
    
    private func initBooks() {
        setEmptySearchResult {
            self.tableView.reloadData()
        }
    }
    
    func setEmptySearchResult(completion: @escaping () -> Void) {
        books = []
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let query = db.collection("Users").document(userID)
        query.addSnapshotListener { snapshot, error in
            print(error ?? "OK user")
            guard let snapshot = snapshot else {
                completion()
                return
            }
            let data = snapshot.data()
            let lib = data?["library"] as? [String : String]
            if lib == nil {
                completion()
                return
            }
            books = []
            for (bookid, _) in lib ?? [:] {
                self.db.collection("Books").document(bookid).addSnapshotListener { snapshot, error in
                    print(error ?? "OK user")
                    guard let snapshot = snapshot else {
                        completion()
                        return
                    }
                    let data = snapshot.data()
                    let authors = data?["authors"] as? String ?? "Автор"
                    let title = data?["title"] as? String ?? "Название"
                    var image = data?["image"] as? String ?? "BookCover"
                    if image == "" {
                        image = "BookCover"
                    }
                    books.append(BookInfo(id: bookid, title: title, authors: self.splitAuthors(authors: authors), image: image))
                    completion()
                }
            }
            completion()
        }
    }
    
    func makeStringAuthors(authors: [String]) -> String {
        let stringAuthors = authors.joined(separator: ", ")
        return stringAuthors
    }
    
    private func updateLastBookDB(bookID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(userID).updateData(["lastBook": bookID])
    }
    
    func setSearchResult(resultBooks: [BookInfo]) {
        books = resultBooks
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        setupSearchBookBar()
        setupTableView()
        setupAddBookButton()
        setupAddBookLabel1()
        setupAddBookLabel2()
    }
    
    private func setupSearchBookBar() {
        searchBookBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0xfffcf4)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddBookButton() {
        addBookButton.addTarget(self, action: #selector(didTapAddBookButton), for: .touchUpInside)
        addBookButton.setImage(UIImage(named: "addNewBook.png"), for: .normal)
        addBookButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddBookLabel1() {
        addBookLabel1.text = "Не нашли книгу?"
        addBookLabel1.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        addBookLabel1.textColor = UIColor.black
        addBookLabel1.textAlignment = .left
        addBookLabel1.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddBookLabel2() {
        addBookLabel2.text = "Вы можете добавить ее вручную"
        addBookLabel2.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        addBookLabel2.numberOfLines = 0
        addBookLabel2.textColor = UIColor.black
        addBookLabel2.textAlignment = .left
        addBookLabel2.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        createSearchBookBarConstraint()
        createLibraryTableConstraint()
        createAddBookButtonConstraint()
        createAddBookLabel1Constraint()
        createAddBookLabel2Constraint()
    }
    
    private func createSearchBookBarConstraint() {
        searchBookBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBookBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchBookBar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        searchBookBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createLibraryTableConstraint() {
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBookBar.bottomAnchor, constant: 10).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: addBookLabel1.topAnchor, constant: -15).isActive = true
    }

    private func createAddBookButtonConstraint() {
        addBookButton.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20).isActive = true
        addBookButton.topAnchor.constraint(equalTo: addBookLabel1.topAnchor).isActive = true
        addBookButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        addBookButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        addBookButton.layer.shadowColor = UIColor.black.cgColor
        addBookButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        addBookButton.layer.shadowOpacity = 0.7
        addBookButton.layer.masksToBounds = false
    }
    
    private func createAddBookLabel1Constraint() {
        addBookLabel1.leftAnchor.constraint(equalTo: addBookButton.rightAnchor, constant: 10).isActive = true
        addBookLabel1.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        addBookLabel1.bottomAnchor.constraint(equalTo: addBookLabel2.topAnchor, constant: 4).isActive = true
    }
    
    private func createAddBookLabel2Constraint() {
        addBookLabel2.leftAnchor.constraint(equalTo: addBookButton.rightAnchor, constant: 10).isActive = true
        addBookLabel2.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        addBookLabel2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    
    public func alert(message: String, complition: (() -> Void)? = nil) {
        alert(message: message, title: "Ошибка", complition: complition)
    }
    
    public func alert(message: String, title: String, complition: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
            complition?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearching = false
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search(_:)), object: searchBar)

        // Check if searh text is empty
        var delay: TimeInterval
        if let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) == "" {
            searchBookBar.stopAnimationLoading()
            delay = 0
        } else {
            delay = 0.5
            searchBookBar.startAnimationLoading()
        }
        perform(#selector(self.search(_:)), with: searchBar, afterDelay: delay)
    }

    @objc private func search(_ searchBar: UISearchBar) {
        // Check for empty query
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        
        // Send request
        searchModel.search(query: query) { [weak self] searchResult in
            DispatchQueue.main.async {
                self?.searchBookBar.stopAnimationLoading()
                if searchResult.books.count == 0 {
                    isSearching = false
                    self?.tableView.reloadData()
                } else {
                    booksInLibrary = searchResult.books
                    isSearching = true
                    self?.tableView.reloadData()
//                    isSearching = false
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }
}
