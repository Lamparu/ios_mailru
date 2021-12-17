//
//  ProfileViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 29.11.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {

    let db = Firestore.firestore()
    
    let changePswdButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapChangePswdButton), for: .touchUpInside)
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
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 30)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupUserLables()
        
        [changePswdButton, signOutButton,
         usernameLabel, emailLable].forEach {view.addSubview($0)}
        
        setupConstraints()
        setupShadows()
        setupBackButton()
    }
    
    private func setupUserLables() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection("Users").document(userID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let username = document.get("username")
                let email = document.get("email")
                self.usernameLabel.text = username as? String
                self.emailLable.text = email as? String
            } else {
                print("Document does not exist")
            }
        }
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
        usernameLabel.bottomAnchor.constraint(equalTo: changePswdButton.topAnchor, constant: -100).isActive = true
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
    
    private func showMessageAlert(err: String) {
        let alert = UIAlertController(title: "Ошибка", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlert(str: String) {
        let alert = UIAlertController(title: "Внимание", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapChangePswdButton(_ sender: UIButton) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection("Users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let email = document.get("email") else { return }
                Auth.auth().sendPasswordReset(withEmail: email as? String ?? "") { error in
                    if error != nil {
                        guard let err = error else { return }
                        guard let errCode = AuthErrorCode(rawValue: err._code) else { return }
                        switch errCode {
                        case .invalidEmail:
                            self.showMessageAlert(err: "Введите корректную электронную почту")
                        case .networkError:
                            self.showMessageAlert(err: "Ошибка Интернет-соединения")
                        case .userNotFound:
                            self.showMessageAlert(err: "Пользователь не найден")
                        default:
                            self.showMessageAlert(err: "Неизвестная ошибка")
                        }
                    } else {
                        self.showAlert(str: "На электронную почту отправлено письмо для смены пароля")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
