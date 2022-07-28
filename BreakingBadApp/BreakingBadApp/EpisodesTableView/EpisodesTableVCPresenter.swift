//
//  EpisodesTableVCPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import Foundation

protocol EpisodesTableVCPresenterProtocol {
    func getEpisodesList()
    func numberOfRows() -> Int
    func getEpisode(at indexPath: IndexPath) -> Episode
    func filterEpisodes() -> [Episode]
    init(view: EpisodesTableViewController, episodes: [Episode], characterName: String?)
}

class EpisodesTableVCPresenter {
    
    unowned private var view: EpisodesTableViewController!
    private var episodes: [Episode]
    private let characterName: String?
    
    required init(view: EpisodesTableViewController, episodes: [Episode], characterName: String?) {
        self.view = view
        self.episodes = episodes
        self.characterName = characterName
    }
}

extension EpisodesTableVCPresenter: EpisodesTableVCPresenterProtocol {
    
    func filterEpisodes() -> [Episode] {
        var filteredEpisodes: [Episode] = []
        for episode in episodes {
            guard let characterName = characterName else { return [] }
            if ((episode.characters?.contains(characterName)) != nil) {
                filteredEpisodes.append(episode)
            }
        }
        return filteredEpisodes
    }
    
    func getEpisodesList() {
        NetworkManager.shared.fetchEpisodes(from: Link.episodes.rawValue) { [unowned self] result in
            switch result {
            case .success(let episodes):
                self.episodes = episodes
                self.view.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        episodes.count
    }
    
    func getEpisode(at indexPath: IndexPath) -> Episode {
        episodes[indexPath.row]
    }
}
