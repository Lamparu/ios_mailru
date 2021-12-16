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

    @objc private func didTapOverallButton(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            loadBook()
//            (bookTitleData, bookAuthorData, bookImageData, bookPagesData) = getBookData()
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
                print("Current data: \(lib)")
                let bookRef = self.db.collection("Books").document(lastBook.trimmingCharacters(in: .whitespaces)).addSnapshotListener{ docSnap, err in
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
                    print("Current data: \(data)")
//                    completion(bookTitleData, bookAuthorData, bookImageData)
                }
                print("aaaaa")
                print(bookTitleData, bookAuthorData, bookImageData)
                
        }
//        let bookRefColl = db.collection("Books")
        print(userRef)
    }
}
