//
//  LybraryViewController.swift
//  FlicksBox
//
//  Created by Анастасия Московчук on 01.11.2021.
//
import UIKit
import Firebase
import FirebaseFirestore

//var books: [BookInfo] = []
var books = [BookInfo]()

final class LibraryViewController: BooksTableViewController {
    
    let db = Firestore.firestore()
    
//    private var books: [Book] = [.init(id: "1", title: "Гордость и предубеждение", author: "Джейн Остен", image: URL(string: ""))]
    let searchBookBar = SearchBarView()
    let addBookButton = UIButton()
    let addBookLabel1 = UILabel()
    let addBookLabel2 = UILabel()
    
    func splitAuthors(authors: String) -> [String] {
        let listAuthors = authors.split{$0 == ","}.map(String.init)
        let trimmedAuthors = listAuthors.map { $0.trimmingCharacters(in: .whitespaces) }
        return trimmedAuthors
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
    
    private func initBooks() {
        setEmptySearchResult {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        [searchBookBar, tableView, addBookButton, addBookLabel1, addBookLabel2].forEach { view.addSubview($0) }
        books = []
        initBooks()
//        setEmptySearchResult()
        print(books)
//        self.tableView.reloadData()
        
        configureGestures()
        
        setupConstraints()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        print("bool", book.title, "section", indexPath.section, "row", indexPath.row)

        cell.configure(with: book)
    
        
    
        return cell
    }
    
    func makeStringAuthors(authors: [String]) -> String {
        let stringAuthors = authors.joined(separator: ", ")
        return stringAuthors
    }
    
    private func updateLastBookDB(bookID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(userID).updateData(["lastBook": bookID])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let book = books[indexPath.section]
        
        updateLastBookDB(bookID: book.id)
        
        let destination = TabBarController()
        navigationController?.pushViewController(destination, animated: true)
       }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    @objc private func didTapAddBookButton(_ sender: UIButton) {
        let AddNewBookViewController = AddNewBookViewController()
        let navController = UINavigationController(rootViewController: AddNewBookViewController)
        self.present(navController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(AddNewBookViewController, animated: true)
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
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
//        tapGesture.cancelsTouchesInView = false

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
        
        
//        let scrollGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        scrollGesture.delegate = resultsGridView.collectionView
//        self.resultsGridView.collectionView.addGestureRecognizer(scrollGesture)
//        scrollGesture.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBookBar.searchBar.resignFirstResponder()
        searchBookBar.searchBar.setShowsCancelButton(false, animated: true)
    }
    
//    @objc  func didTapMainVC(sender: UITapGestureRecognizer) {
//        if sender.state == UIGestureRecognizer.State.ended {
//            let tapLocation = sender.location(in: self.tableView)
//            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
//                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? LibraryTableViewCell {
//                        let AddNewBookViewController = TabBarController()
//                        self.navigationController?.pushViewController(AddNewBookViewController, animated: true)
//
//                    }
//                }
//            }
//        
//    }
//    
    
    
    
    private func setupUI() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        setupSearchBookBar()
        setupTableView()
        setupAddBookButton()
        setupAddBookLabel1()
        setupAddBookLabel2()
    }
    
    private func setupSearchBookBar() {
//        searchBookBar.barTintColor = UIColor(rgb: 0xfffcf4)
//        searchBookBar.tintColor = UIColor(rgb: 0x666568)
//        searchBookBar.isTranslucent = true
//        searchBookBar.showsCancelButton = true
//        searchBookBar.backgroundColor = UIColor.red
        searchBookBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableView() {
//        books = BookInfo.shared.loadBooks()
        
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
//        addBookLabel1.textColor = UIColor(rgb: 0x6A7F60)
        addBookLabel1.textAlignment = .left
        addBookLabel1.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddBookLabel2() {
        addBookLabel2.text = "Вы можете добавить ее вручную"
        addBookLabel2.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        addBookLabel2.numberOfLines = 0
        addBookLabel2.textColor = UIColor.black
//        addBookLabel2.textColor = UIColor(rgb: 0x6A7F60)
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
//        tableView.heightAnchor.constraint(equalToConstant: 530).isActive = true
    }

    private func createAddBookButtonConstraint() {
        addBookButton.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20).isActive = true
//        addBookLabel2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
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
//        addBookLabel1.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func createAddBookLabel2Constraint() {
        addBookLabel2.leftAnchor.constraint(equalTo: addBookButton.rightAnchor, constant: 10).isActive = true
        addBookLabel2.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        addBookLabel2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
//        addBookLabel2.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
    
extension LibraryViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
//        showRecommendationsGridView()
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
//            showRecommendationsGridView()
            return
        }
        
        // Send request
//        searchModel.search(query: query) { [weak self] searchResult in
//            DispatchQueue.main.async {
//                self?.searchBarView.stopAnimationLoading()
//                if searchResult.content.count == 0 && searchResult.actors.count == 0 {
//                    self?.showEmptyResultView()
//                } else {
//                    self?.resultsGridView.updateData(content: searchResult.content, actors: searchResult.actors)
//                    self?.showResultsGridView()
//                }
//            }
//        } failure: { [weak self] error in
//            DispatchQueue.main.async {
//                self?.alert(message: error)
//            }
//        }
    }
}
