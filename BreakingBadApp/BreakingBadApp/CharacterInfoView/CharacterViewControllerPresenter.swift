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
    
    private let view: CharacterViewControllerProtocol?
    private let character: Character
    
    required init(view: CharacterViewControllerProtocol, character: Character) {
        self.view = view
        self.character = character
    }
    
    func getArrayOfStringsFromCharacter(character: Character) -> [String] {
        var arrayOfStrings: [String] = []
        
        if let name = character.name {
            let header = "Name: "
            arrayOfStrings.append(name)
            arrayOfStrings.append(header + name)
        } else { arrayOfStrings.append("No Data")}
        
        if let birthday = character.birthday {
            let header = "Birthday: "
            arrayOfStrings.append(header + birthday)
        } else { arrayOfStrings.append("No Data")}
        
        if let occupation = character.occupation {
            let header = "Occupation: "
            let stringFromOccupation = occupation.joined(separator: ", ")
            arrayOfStrings.append(header + stringFromOccupation)
        } else { arrayOfStrings.append("No Data")}
        
        if let status = character.status {
            let header = "Status: "
            arrayOfStrings.append(header + status)
        } else { arrayOfStrings.append("No Data")}
        
        if let nickname = character.nickname {
            let header = "NickName: "
            arrayOfStrings.append(header + nickname)
        } else { arrayOfStrings.append("No Data")}
        
        if let appearance = character.appearance {
            let header = "Appearance: "
            arrayOfStrings
                .append(
                    header +
                    appearance
                        .compactMap{ String($0) }
                        .joined(separator: ", ")
                )
        } else { arrayOfStrings.append("No Data")}
        
        if let portrayed = character.portrayed {
            let header = "Portrayed: "
            arrayOfStrings.append(header + portrayed)
        } else { arrayOfStrings.append("No Data")}
        
        if let category = character.category {
            let header = "Category: "
            arrayOfStrings.append(header + category)
        } else { arrayOfStrings.append("No Data")}
        
        if character.betterCallSaulAppearance == [] {
            let header = "BetterCallSaulAppearance: "
            arrayOfStrings.append(header + "did not appear")
        } else if let betterCallSaulAppearance = character.betterCallSaulAppearance {
            let header = "BetterCallSaulAppearance: "
            arrayOfStrings
                .append(
                    header + 
                    betterCallSaulAppearance
                    .compactMap{ String($0) }
                    .joined(separator: ", ")
                )
        }  else { arrayOfStrings.append("No Data")}
        
        return arrayOfStrings
    }
}

extension CharacterViewControllerPresenter: CharacterInfoViewControllerPresenterProtocol {
    
    func setUpImage() {
        guard let stringUrl = character.img else { return }
        
        guard let url = URL(string: stringUrl) else {
            guard self.view != nil else { return }
            self.view?.showErrorImage()
            return
        }
        
        // Используем изображение из кеша, если оно там есть
        if let cachedImageData = getCachedImage(from: url) {
            guard self.view != nil else { return }
            self.view?.showImage(from: cachedImageData)
            return
        }
        // Если изображения нет в кэше то загружаем из сети
        ImageManager.shared.fetchImage(from: character) { data, response in
            guard self.view != nil else { return }
            self.view?.showImage(from: data)
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    
    private func getCachedImage(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
    
    func setupLabelsText() {
        view?.showLabelsText(from: getArrayOfStringsFromCharacter(character: character))
    }
}
