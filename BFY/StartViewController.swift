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
//            setEmptySearchResult()
            let tabBarVC = TabBarController()
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        } else {
            let authVC = AuthViewController()
            self.navigationController?.pushViewController(authVC, animated: false)
        }
        
    }
}
