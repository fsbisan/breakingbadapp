//
//  CharacterImageView.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 31.07.2022.
//

import Foundation
import UIKit

//class CharacterImageView: UIImageView {
//    func fetchImage(from url: String) {
//        guard let url = URL(string: url) else {
//            image = UIImage(named: "garryPotter")
//            return
//        }
//        
//        // Используем изображение из кеша, если оно там есть
//        if let cachedImage = getCachedImage(from: url) {
//            image  = cachedImage
//            return
//        }
//        
//        // Если изображения нет в кэше то загружаем из сети
//        ImageManager.shared.fetchImage(from: url) { data, response in
//            self.image = UIImage(data: data)
//            self.saveDataToCache(with: data, and: response)
//        }
//    }
//    
//    private func saveDataToCache(with data: Data, and response: URLResponse) {
//        guard let url = response.url else { return }
//        let urlRequest = URLRequest(url: url)
//        let cachedResponse = CachedURLResponse(response: response, data: data)
//        
//        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
//    }
//    
//    private func getCachedImage(from url: URL) -> UIImage? {
//        let request = URLRequest(url: url)
//        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
//            return UIImage(data: cachedResponse.data)
//        }
//        return nil
//    }
//}
