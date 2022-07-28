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
    func getCharacter(at indexPath: IndexPath) -> Character
    init(characters: [Character], view: StartTableViewController)
}

class CharacterStarViewControllerPresenter {
    private var characters: [Character]
    unowned private var view: StartTableViewController
    
    required init(characters: [Character], view: StartTableViewController) {
        self.characters = characters
        self.view = view
    }
}

extension CharacterStarViewControllerPresenter: CharacterViewControllerPresenterProtocol {
    func getCharacterList() {
        NetworkManager.shared.fetchCharacters(from: Link.characters.rawValue) { [unowned self] result  in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.view.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        characters.count
    }
    
    func getCharacter(at indexPath: IndexPath) -> Character {
        characters[indexPath.row]
    }
    
}
