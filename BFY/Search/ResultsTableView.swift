//
//  ResultsGridView.swift
//  BFY
//
//  Created by Анастасия Московчук on 30.11.2021.
//

import UIKit
//import Botticelli

protocol ResultsGridViewDelegate: AnyObject {
    func didSelectBook(book: Book)
//    func didSelectTitle(title: Title)
}

final class ResultsTableView: LibraryViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableCell", for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
//        let book = books[indexPath.row]
                
//        cell.configure(with: book)

        return cell
    }

}
