//
//  EndingScreenViewController.swift
//  BFY
//
//  Created by Полина Подчуфарова on 11.12.2021.
//

import UIKit

class EndingScreenViewController: UIViewController {
    
//    let stringQuestion: UILabel = {
//        let text = "Уверены,\nчто хотите завершить чтение?"
//        let str = UILabel()
//        str.text = text
//        str.numberOfLines = 2
//        str.textColor = UIColor.white
//        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
//        str.textAlignment = .center
//        str.translatesAutoresizingMaskIntoConstraints = false
//        return str
//    }()
    
    let stringLists: UILabel = {
        let text = "Введите номер страницы"
        let str = UILabel()
        str.text = text
        str.textColor = UIColor.white
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    var numberOfListsField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.textAlignment = .center
    textField.layer.cornerRadius = 10
    //textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    textField.layer.masksToBounds = true
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.resignFirstResponder()

    return textField
    }()
    
    let yesButton: UIButton = {
        let playButton = UIButton()
        playButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        let imageName = "save"
        let image = UIImage(named: imageName)
        playButton.setImage(UIImage(named: imageName), for: .normal)
//        playButton.layer.cornerRadius=70
//        playButton.layer.masksToBounds = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        //view.addSubview(stringQuestion)
        view.addSubview(stringLists)
        view.addSubview(numberOfListsField)
        view.addSubview(yesButton)
        
        //createstringQuestionConstraint()
        createstringListsConstraint()
        createnumberOfListsFieldConstraint()
        createyesButtons(button: yesButton)
        
        // Do any additional setup after loading the view.
    }
//    func createstringQuestionConstraint() {
//        stringQuestion.widthAnchor.constraint(equalToConstant: 400).isActive = true
//        stringQuestion.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        stringQuestion.centerXAnchor.constraint(equalTo: numberOfListsField.centerXAnchor).isActive = true
//        stringQuestion.centerYAnchor.constraint(equalTo: numberOfListsField.bottomAnchor, constant: 100).isActive = true
//    }
    
    func createstringListsConstraint() {
        stringLists.widthAnchor.constraint(equalToConstant: 400).isActive = true
        stringLists.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stringLists.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stringLists.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
    }
    
    func createnumberOfListsFieldConstraint() {
        numberOfListsField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        numberOfListsField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        numberOfListsField.centerXAnchor.constraint(equalTo: stringLists.centerXAnchor).isActive = true
        numberOfListsField.centerYAnchor.constraint(equalTo: stringLists.bottomAnchor, constant: 30).isActive = true
    }
    func createyesButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.centerXAnchor.constraint(equalTo: numberOfListsField.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: numberOfListsField.bottomAnchor, constant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 67).isActive = true
        button.widthAnchor.constraint(equalToConstant: 201).isActive = true
    }
    
    
    @objc private func didTapRegButton(_ sender: UIButton) {
            self.dismiss(animated: true)
    }

}
