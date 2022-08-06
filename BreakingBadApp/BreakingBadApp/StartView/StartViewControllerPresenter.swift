//
//  StartViewControllerPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation
protocol CharacterViewControllerPresenterProtocol: AnyObject {
    func getCharacterList()
    func numberOfRows() -> Int
    func getCharacter(at indexPath: IndexPath) -> Character?
    func filterContentForSearchText(_ searchText: String)
    var isFiltering: Bool { get }
    init(characters: [Character], view: StartTableViewController)
}

class CharacterStarViewControllerPresenter {
    private var characters: [Character]?
    private var filteredCharacters: [Character]?
    weak private var view: StartTableViewController?
    
    required init(characters: [Character], view: StartTableViewController) {
        self.characters = characters
        self.view = view
    }
}

extension CharacterStarViewControllerPresenter: CharacterViewControllerPresenterProtocol {
    var isFiltering: Bool {
        view?.searchController.isActive ?? false && !(view?.searchBarIsEmpty ?? true)
    }
    
    func getCharacterList() {
        NetworkManager.shared.fetchCharacters(from: Link.characters.rawValue) { [weak self] result  in
            switch result {
            case .success(let characters):
                guard self?.view != nil else { return }
                guard self?.characters != nil else { return }
                self?.characters = characters
                self?.view?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return isFiltering ? (filteredCharacters?.count ?? 0) : (characters?.count ?? 0)
    }
    
    func numberOfFilteredRows() -> Int {
        filteredCharacters?.count ?? 0
    }
    
    func getCharacter(at indexPath: IndexPath) -> Character? {
        if isFiltering {
            guard let character = filteredCharacters?[indexPath.row] else { return nil }
            return character
        }
        guard let character = characters?[indexPath.row] else { return nil }
        return character
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = characters?.filter({ character in
            guard let isContain = character.name?
                .lowercased()
                .contains(searchText.lowercased()) else { return false}
            return isContain
        })
        view?.tableView.reloadData()
    }
    
}
