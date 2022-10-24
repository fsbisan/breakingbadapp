//
//  StartTableViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import UIKit

class StartTableViewController: UITableViewController {
    
    var charactersList: [Character] = []
    var presenter: CharacterViewControllerPresenterProtocol!

    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        presenter = CharacterStarViewControllerPresenter(characters: charactersList,
                                                         view: self)
        presenter.getCharacterList()
        view.backgroundColor = .white
        tableView.rowHeight = 100
        setupNavigationBar()
        /// Размер кэша для изображений в байтах
        URLCache.shared.diskCapacity = 25000000
        /// Настраиваем SearchController
        setupSearchController()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterTableViewCell.cellIdentifier,
            for: indexPath
        ) as! CharacterTableViewCell
        cell.character = presenter.getCharacter(at: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let characterVC = CharacterViewController()
        characterVC.character = presenter.getCharacter(at: indexPath)
        let characterNavContrVC = UINavigationController(rootViewController: characterVC)
        characterNavContrVC.modalPresentationStyle = .fullScreen
        present(characterNavContrVC, animated: true)
    }
    
    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "back",
            style: .plain,
            target: self,
            action: #selector(closeView)
            )
    }
    
    @objc private func closeView() {
        dismiss(animated: true)
    }
    
    private func setupSearchController() {
        /// Получателем информации об изменении текста в поисковой строке должен быть наш класс
        searchController.searchResultsUpdater = self
        /// Разрешаем взаимодействие с отфильтрованным контентом как и с основным
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search"
        navigationItem.searchController = searchController
        /// Позволяет опустить строку поиска при переходе на другой экран
        definesPresentationContext = true
    }
}

extension StartTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter.filterContentForSearchText(text)
    }
}
