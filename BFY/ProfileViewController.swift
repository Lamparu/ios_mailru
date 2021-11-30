//
//  ProfileViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 29.11.2021.
//

import UIKit
import Firebase 

class ProfileViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        [changePswdButton, signOutButton].forEach {view.addSubview($0)}
        
        setupConstraints()
        setupShadows()
    }
    
    private func setupShadows() {
        applyShadowOnButtons(button: changePswdButton)
        applyShadowOnButtons(button: signOutButton)
    }
    
    private func setupConstraints() {
        createSignOutButtonConstraint()
        createChangePswdButtonConstraint()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
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
