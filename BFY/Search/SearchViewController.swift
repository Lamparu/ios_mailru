//
//  SearchViewController.swift
//  BFY
//
//  Created by Анастасия Московчук on 14.12.2021.
//

//import UIKit
//import Botticelli
//
//final class SearchViewController: UIViewController {
//    private let searchModel = SearchModel()
//    private let recModel = RecommendationsModel()
//
//    private lazy var resultsTableView: ResultsTableView = {
//        let viewFrame = CGRect(
//            x: view.bounds.minX,
//            y: searchBarView.bounds.maxY,
//            width: view.bounds.width,
//            height: view.bounds.height - searchBarView.bounds.maxY - 50
//        )
//        let rgv = resultsTableView(frame: viewFrame)
//        rgv.delegate = self
//        return rgv
//    }()
//
//    private lazy var recGridView: RecommendationsGridView = {
//        let viewFrame = CGRect(
//            x: view.bounds.minX,
//            y: searchBarView.bounds.maxY + 10,
//            width: view.bounds.width,
//            height: view.bounds.height - searchBarView.bounds.maxY - 100
//        )
//        let rgv = RecommendationsGridView(frame: viewFrame)
//        rgv.delegate = self
//        return rgv
//    }()
//
//    private lazy var emptyResultView: SearchEmptyResultView = {
//        let sideSpace: CGFloat = 20
//        let viewFrame = CGRect(
//            x: view.bounds.minX + sideSpace,
//            y: view.bounds.minY,
//            width: view.bounds.width - sideSpace * 2,
//            height: view.bounds.height - 300
//        )
//        return SearchEmptyResultView(frame: viewFrame)
//    }()
//
//    private lazy var searchBarView: SearchBarView = {
//        var viewFrame = CGRect(
//            x: view.bounds.minX,
//            y: view.bounds.minY,
//            width: view.bounds.width,
//            height: 100
//        )
//        return SearchBarView(frame: viewFrame)
//    }()
//
//    private lazy var searchBar: UISearchBar = {
//        let searchBar = searchBarView.searchBar
//        searchBar.delegate = self
//        return searchBar
//    }()
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//        searchBar.becomeFirstResponder()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(emptyResultView)
//        view.addSubview(resultsGridView)
//        view.addSubview(recGridView)
//        view.addSubview(searchBarView)
//        showRecommendationsGridView()
//        configureGestures()
//        loadRecommendations()
//    }
//
//    private func configureGestures() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
//        tapGesture.cancelsTouchesInView = false
//
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(panGesture)
//        panGesture.cancelsTouchesInView = false
//
//        let scrollGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        scrollGesture.delegate = resultsGridView.collectionView
//        self.resultsGridView.collectionView.addGestureRecognizer(scrollGesture)
//        scrollGesture.cancelsTouchesInView = false
//    }
//
//    private func loadRecommendations() {
//        recModel.loadData() { [weak self] content in
//            DispatchQueue.main.async {
//                self?.recGridView.updateData(content)
//            }
//        } failure: { [weak self] error in
//            DispatchQueue.main.async {
//                self?.alert(message: error)
//            }
//        }
//    }
//
//    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        searchBar.resignFirstResponder()
//        searchBar.setShowsCancelButton(false, animated: true)
//    }
//
//    private func showEmptyResultView() {
//        emptyResultView.isHidden = false
//        resultsGridView.isHidden = true
////        recGridView.isHidden = true
//    }
//
//    private func showResultsGridView() {
//        emptyResultView.isHidden = true
//        resultsTableView.isHidden = false
////        recGridView.isHidden = true
//    }
//
//    private func showRecommendationsGridView() {
//        emptyResultView.isHidden = true
//        resultsGridView.isHidden = true
//        recGridView.isHidden = false
//    }
//}
//
//extension SearchViewController: MainOutput {
//    func prepareForUse() {
//        self.tabBarItem.title = "Поиск"
//        self.tabBarItem.image = SBIcon.search
//    }
//}
//
//extension SearchViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(true, animated: true)
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(false, animated: true)
//        searchBar.resignFirstResponder()
//        searchBar.text = ""
//        showRecommendationsGridView()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search(_:)), object: searchBar)
//
//        // Check if searh text is empty
//        var delay: TimeInterval
//        if let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) == "" {
//            self.searchBarView.stopAnimationLoading()
//            delay = 0
//        } else {
//            delay = 0.5
//            searchBarView.startAnimationLoading()
//        }
//        perform(#selector(self.search(_:)), with: searchBar, afterDelay: delay)
//    }
//
//    @objc private func search(_ searchBar: UISearchBar) {
//        // Check for empty query
//        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
//            showRecommendationsGridView()
//            return
//        }
//
//        // Send request
//        searchModel.search(query: query) { [weak self] searchResult in
//            DispatchQueue.main.async {
//                self?.searchBarView.stopAnimationLoading()
//                if searchResult.content.count == 0 && searchResult.actors.count == 0 {
//                    self?.showEmptyResultView()
//                } else {
//                    self?.resultsGridView.updateData(content: searchResult.content, actors: searchResult.actors)
//                    self?.showResultsGridView()
//                }
//            }
//        } failure: { [weak self] error in
//            DispatchQueue.main.async {
//                self?.alert(message: error)
//            }
//        }
//    }
//}
//
//extension SearchViewController: RecommendationsGridViewDelegate {
//    func didSelectCell(content: ContentInfo) {
//        let viewController = FactoryViewControllers.createContentInfo(info: content)
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//}
//
//extension SearchViewController: ResultsGridViewDelegate {
//    func didSelectContent(content: ContentInfo) {
//        let viewController = FactoryViewControllers.createContentInfo(info: content)
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//
//    func didSelectActor(actor: Actor) {
//        let viewController = FactoryViewControllers.createActorContent(actor: actor)
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//}
