//
//  SearchEmptyResultView.swift
//  BFY
//
//  Created by Анастасия Московчук on 30.11.2021.
//

import UIKit
//import Botticelli

final class SearchEmptyResultView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    private func configureSubviews() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)
        ]
        let descTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]
        
        let title = NSMutableAttributedString(
            string: "Книга не найдена.",
            attributes: titleTextAttributes
        )
        let desc = NSMutableAttributedString(
            string: "\nПопробуйте выполнить поиск другой книги.",
            attributes: descTextAttributes
        )
        
        let message = NSMutableAttributedString()
        message.append(title)
        message.append(desc)
        
        let messageLabel = UILabel()
        messageLabel.frame = bounds
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        messageLabel.attributedText = message
        addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
