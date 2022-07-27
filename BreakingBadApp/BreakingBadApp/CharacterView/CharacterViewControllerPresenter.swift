//
//  CharacterViewControllerPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 26.07.2022.
//

import Foundation

protocol CharacterInfoViewControllerPresenterProtocol {
    func setUpImage()
    func setupLabelsText()
    init(view: CharacterViewControllerProtocol, character: Character)
}

class CharacterViewControllerPresenter {
    
    private let view: CharacterViewControllerProtocol
    private let character: Character
    
    required init(view: CharacterViewControllerProtocol, character: Character) {
        self.view = view
        self.character = character
    }
    
    func getArrayOfStringsFromCharacter(character: Character) -> [String] {
        var arrayOfStrings: [String] = []
        if let name = character.name {
            arrayOfStrings.append(name)
        } else { arrayOfStrings.append("No Data")}
        
        if let birthday = character.birthday {
            arrayOfStrings.append(birthday)
        } else { arrayOfStrings.append("No Data")}
        
        if let occupation = character.occupation {
            let stringFromOccupation = occupation.joined(separator: ", ")
            arrayOfStrings.append(stringFromOccupation)
        } else { arrayOfStrings.append("No Data")}
        
        if let status = character.status {
            arrayOfStrings.append(status)
        } else { arrayOfStrings.append("No Data")}
        
        if let nickname = character.nickname {
            arrayOfStrings.append(nickname)
        } else { arrayOfStrings.append("No Data")}
        
        if let appearance = character.appearance {
            arrayOfStrings
                .append(
                    appearance
                        .compactMap{ String($0) }
                        .joined(separator: ", ")
                )
        } else { arrayOfStrings.append("No Data")}
        
        if let portrayed = character.portrayed {
            arrayOfStrings.append(portrayed)
        } else { arrayOfStrings.append("No Data")}
        
        if let category = character.category {
            arrayOfStrings.append(category)
        } else { arrayOfStrings.append("No Data")}
        
        if let betterCallSaulAppearance = character.betterCallSaulAppearance {
            arrayOfStrings
                .append(
                    betterCallSaulAppearance
                    .compactMap{ String($0) }
                    .joined(separator: ", ")
                )
        } else { arrayOfStrings.append("No Data")}
        
        return arrayOfStrings
    }
}

extension CharacterViewControllerPresenter: CharacterInfoViewControllerPresenterProtocol {
    
    func setUpImage() {
        DispatchQueue.global().async {
            guard let imageData = NetworkManager.shared.fetchImage(from: self.character) else { return }
            DispatchQueue.main.async {
                self.view.showImage(from: imageData)
            }
        }
    }
    
    func setupLabelsText() {
        view.showLabelsText(from: getArrayOfStringsFromCharacter(character: character)) 
    }
}
