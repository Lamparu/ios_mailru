//
//  BookManager.swift
//  BFY
//
//  Created by Анастасия Московчук on 16.11.2021.
//

import Foundation

protocol BookManagerProtocol {  //закрыли протоколом, чтобы сделать инверсию зависимостей, чтобы в любой момент можно было подменить любым другим менеджером, который реализует этот протокол
//    var output: BookManagerOutput? { get set }
    
    func loadBooks() -> [Book]  //по лекции про сетевое взаимодействие подправить
}

//protocol BookManagerOutput: AnyObject {
//    func didReceive(_ books: [Book])
//}

class BookManager: BookManagerProtocol {
    static let shared: BookManagerProtocol = BookManager()  //это синглтон (для объектов, которые в проекте нужны в единственном экземпляре)
    
//    weak var output: BookManagerOutput?
    
    private init() {}
    
    func loadBooks() -> [Book] {
        return [
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),
            Book(title: "Капитанская дочка", author: "А.С. Пушкин", image: nil),
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),
            Book(title: "Капитанская дочка", author: "А.С. Пушкин", image: nil),
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),
            Book(title: "Капитанская дочка", author: "А.С. Пушкин", image: nil),
            Book(title: "Капитанская дочка", author: "А.С. Пушкин", image: nil),
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),
            Book(title: "Руслан и Людмила", author: "А.С. Пушкин", image: nil),

        ]
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let books = [
//                Book(title: "iPad Mini 2030", price: "499 $", isVerified: Bool.random(), imageUrl: URL(string: "https://www.iphones.ru/wp-content/uploads/2018/11/01FBA0D1-393D-4E9F-866C-F26F60722480.jpeg")),
//                Book(title: "iPhone 13 Pro", price: "1299 $", isVerified: Bool.random(), imageUrl: URL(string: "https://berryblog.ru/wp-content/uploads/2017/09/gettyimages-846148982.jpg")),
//                Book(title: "Apple Watch 7", price: "499 $", isVerified: Bool.random(), imageUrl: URL(string: "https://pbs.twimg.com/media/DnFbBdYVsAAqnXN.jpg"))
//            ]
//
//            self.output?.didReceive(books)
    }
}

