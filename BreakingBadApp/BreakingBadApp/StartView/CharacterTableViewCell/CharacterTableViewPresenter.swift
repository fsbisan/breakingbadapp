//
//  CharacterTableViewPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation
protocol CharacterTableViewCellPresenterProtocol: AnyObject {
    init(view: CharacterTableViewCellProtocol, character: Character?)
    func setImage()
    func setName()
}

class CharacterTableViewCellPresenter: CharacterTableViewCellPresenterProtocol {
    
    unowned private let view: CharacterTableViewCellProtocol
    private let character: Character?
    
    required init(view: CharacterTableViewCellProtocol, character: Character?) {
        self.view = view
        self.character = character
    }
    
    func setImage() {
        guard let character = character else { return }
        DispatchQueue.global().async {
            guard let imageData = NetworkManager.shared.fetchImage(from: character) else { return }
            DispatchQueue.main.async {
                self.view.showImage(data: imageData)
            }
        }
    }
    
    func setName() {
        guard let character = character else { return }
        guard let name = character.name else { return }
        view.showName(characterName: name)
    }
    
}
