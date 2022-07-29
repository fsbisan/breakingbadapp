//
//  NetworkManager.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static var shared = NetworkManager()
    
    func fetchCharacters(from url: String, completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(characters))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    func fetchCharacter(byName name: String, completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        let urlString = "https://www.breakingbadapi.com/api/characters?name=\(name)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let character = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    func fetchEpisodes(from url: String, completion: @escaping(Result<[Episode], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(episodes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchEpisode(from url: String, completion: @escaping(Episode) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchQuote(from url: String, completion: @escaping(Quote) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Quote.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from character: Character) -> Data? {
            guard let stringUrl = character.img else { return nil}
            guard let imageUrl = URL(string: stringUrl) else { return nil}
            return try? Data(contentsOf: imageUrl)
    }
    
    private init() {}
}
