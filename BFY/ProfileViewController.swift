//
//  ProfileViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 29.11.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
//    guard let userID: String = Auth.auth().currentUser?.uid else { return label }
    
    let changePswdButton: UIButton = {
        let button = UIButton()
        //button.addTarget(self, action: #selector(didTapChangePswdButton), for: .touchUpInside)
        button.setTitle("Сменить пароль", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        button.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        button.backgroundColor = UIColor(rgb: 0xC8CEBE)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        button.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        button.backgroundColor = UIColor(rgb: 0xC8CEBE)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let usernameLabel: UILabel = {
        let ref = Database.database().reference()
        let label = UILabel()
        guard let userID = Auth.auth().currentUser?.uid else { return label }
        ref.child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            label.text = username
        })
//        label.text = "Логин"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLable: UILabel = {
        let ref = Database.database().reference()
        let label = UILabel()
        guard let userID = Auth.auth().currentUser?.uid else { return label }
        ref.child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            label.text = email
        })
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        [changePswdButton, signOutButton,
         usernameLabel, emailLable].forEach {view.addSubview($0)}
        
        setupConstraints()
        setupShadows()
        setupBackButton()
        
//        let profileVC = ProfileViewController()
//        let bookVC = MainBookViewController()
        
//        let tabBarVC = UITabBarController()
//        tabBarVC.setViewControllers([profileVC, bookVC], animated: true)
//        
//        addChild(tabBarVC)
//        view.addSubview(tabBarVC.view)
//        tabBarVC.didMove(toParent: self)
        
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(rgb: 0x6A7F60)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupShadows() {
        applyShadowOnButtons(button: changePswdButton)
        applyShadowOnButtons(button: signOutButton)
    }
    
    private func setupConstraints() {
        createSignOutButtonConstraint()
        createChangePswdButtonConstraint()
        createUsernameLabelConstraint()
        createEmailLabelConstraint()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    func createEmailLabelConstraint() {
        emailLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLable.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        emailLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailLable.widthAnchor.constraint(equalToConstant: 225).isActive = true
    }
    
    func createUsernameLabelConstraint() {
        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: changePswdButton.topAnchor, constant: -60).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 225).isActive = true
    }
    
    func createSignOutButtonConstraint() {
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: 225).isActive = true
    }
    
    func createChangePswdButtonConstraint() {
        changePswdButton.centerYAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -70).isActive = true
        changePswdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePswdButton.heightAnchor.constraint(equalTo: signOutButton.heightAnchor).isActive = true
        changePswdButton.widthAnchor.constraint(equalTo: signOutButton.widthAnchor).isActive = true
    }
    
    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    @objc private func didTapSignOutButton(_ sender: UIButton) {
        let authVC = AuthViewController()
        do {
            try Auth.auth().signOut()
            self.navigationController?.pushViewController(authVC, animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
