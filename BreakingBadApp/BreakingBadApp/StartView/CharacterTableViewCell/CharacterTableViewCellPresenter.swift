//
//  CharacterTableViewCellPresenter.swift
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
    
    weak private var view: CharacterTableViewCellProtocol?
    private let character: Character?
    
    required init(view: CharacterTableViewCellProtocol, character: Character?) {
        self.view = view
        self.character = character
    }
    
    func setImage() {
        guard let character = character else { return }
        guard let stringUrl = character.img else { return }
        
        guard let url = URL(string: stringUrl) else {
            guard self.view != nil else { return }
            self.view?.showErrorImage()
            return
        }
        
        // Используем изображение из кеша, если оно там есть
        if let cachedImageData = getCachedImage(from: url) {
            guard self.view != nil else { return }
            self.view?.showImage(data: cachedImageData)
            return
        }
        // Если изображения нет в кэше то загружаем из сети
        ImageManager.shared.fetchImage(from: character) { data, response in
            guard self.view != nil else { return }
            self.view?.showImage(data: data)
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
    
    func setName() {
        guard let character = character else { return }
        guard let name = character.name else { return }
        guard self.view != nil else { return }
        view?.showName(characterName: name)
    }
    
}
