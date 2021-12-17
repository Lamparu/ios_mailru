//
//  StartViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 30.11.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

var bookTitleData = ""
var bookAuthorData = ""
var bookPagesData = ""
var bookImageData = ""

class StartViewController: UIViewController {

    let db = Firestore.firestore()
    
    let viewImage: UIImageView = {
        let image = UIImage(named: "BFY")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overallButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapOverallButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(viewImage)
        view.addSubview(overallButton)
        
        setupBackground()
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func  setupConstraints() {
        createOverallButtonConstraint()
        createViewImageConstraint()
    }
    
    private func createOverallButtonConstraint() {
        overallButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        overallButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overallButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overallButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func createViewImageConstraint() {
        viewImage.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
    }
    
    func splitAuthors(authors: String) -> [String] {
        let listAuthors = authors.split{$0 == ","}.map(String.init)
        let trimmedAuthors = listAuthors.map { $0.trimmingCharacters(in: .whitespaces) }
        return trimmedAuthors
    }

    func setEmptySearchResult() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("Users").document(userID)
        let bookRefColl = db.collection("Books")
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let library = document.data() //as! [String: Int]
                let lib = library?["library"] as? [String : String]
                if lib == nil {
                    return
                    // пустой экран
                }
                for (bookid, _) in lib ?? ["":""] {
                    let bookRef = bookRefColl.document(bookid)
                    bookRef.getDocument { (bookDoc, bookErr) in
                        if let bookDoc = bookDoc, bookDoc.exists {
                            let book = bookDoc.data()
                            let title = book?["title"] as? String ?? "Название"
                            let authors = book?["authors"] as? String ?? "Автор"
                            let image = book?["image"] as? String ?? "BookCover"
                            print("image: ", image)
                            let newBook = BookInfo(id: bookid, title: title, authors: self.splitAuthors(authors: authors), image: image)
                            books.append(newBook)
                            print(books)
                        } else {
                            print("Books collection does not exist")
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @objc private func didTapOverallButton(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            setEmptySearchResult()
            let tabBarVC = TabBarController()
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        } else {
            let authVC = AuthViewController()
            self.navigationController?.pushViewController(authVC, animated: false)
        }
        
    }
    
    func loadBook() {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let userRef = db.collection("Users").document(userID)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                    }
                    guard let lib = document.data() else {
                            print("Document data was empty.")
                            return
                    }
                    let lastBook = lib["lastBook"] as? String ?? ""
                    print("Current data111: \(lib)")
                    let bookRef = self.db.collection("Books").document(lastBook.trimmingCharacters(in: .whitespaces)).addSnapshotListener{ docSnap , err  in
                        guard let document = docSnap else {
                                print("Error fetching document: \(error!)")
                                return
                        }
                       
                        guard let data = document.data() else {
                                print("Document data was empty.")
                                return
                        }
                       
                        
                        bookTitleData = data["title"] as? String ?? "Название"
        //                        self.stringBookName.text = title //book?["title"] as? String ?? "Название книги"
                        bookAuthorData = data["authors"] as? String ?? "Автор"
        //                        self.stringBookAuthor.text = authors //book?["authors"] as? String ?? "Автор книги"
                        bookImageData = data["image"] as? String ?? "BookCover"
                        
                        print("Current data2222: \(data)")
    //                    completion(bookTitleData, bookAuthorData, bookImageData)
                        
                        let library = lib["library"] as? [String : String]
                        for (bookid, pages) in library ?? [:] {
                            if bookid == lastBook {
                                bookPagesData  = "\(pages) стр."
                            }
                        }
                     
             }
                    
    //                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
    //                print("HEEELP",bookTitleData, bookAuthorData, bookImageData)
    //                })
            }
    //        let bookRefColl = db.collection("Books")
            print(userRef)
            
        }
    
}
