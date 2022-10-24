//
//  EpisodeInfoVCPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 29.07.2022.
//

import Foundation

protocol EpisodeInfoVCPresenterProtocol {
    func numberOfRows() -> Int
    func setLabelsTexts()
    func getCharacter(at indexPath: IndexPath) -> Character?
    func getCharacterFromEpisode()
    func prepareName(characterName: String) -> String
    init(view: EpisodeInfoVCProtocol, episode: Episode, characters: [Character])
}

class EpisodeInfoVCPresenter {
    let view: EpisodeInfoVCProtocol
    var episode: Episode
    var characters: [Character]
    
    required init(view: EpisodeInfoVCProtocol, episode: Episode, characters: [Character]) {
        self.view = view
        self.episode = episode
        self.characters = characters
    }
}

extension EpisodeInfoVCPresenter: EpisodeInfoVCPresenterProtocol {
    func prepareName(characterName: String) -> String {
        characterName.replacingOccurrences(of: " ", with: "+")
    }
    
    func getCharacterFromEpisode() {
        guard let charactersNames = episode.characters else { return }
        for characterName in charactersNames {
            let preparedCharacterName = prepareName(characterName: characterName)
            NetworkManager.shared.fetchCharacter(byName: preparedCharacterName) { [unowned self] result in
                switch result {
                case .success(let characters):
                    self.characters += characters
                    self.view.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func getCharacter(at indexPath: IndexPath) -> Character? {
      characters[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        characters.count
    }
    
    func setLabelsTexts() {
        var textsForLabels: [String] = []
        
        if let episodeTitle = episode.title {
            textsForLabels.append(episodeTitle)
        } else { textsForLabels.append("No Data") }
        
        if let seasonNumber = episode.season {
            let header = "Season: "
            textsForLabels.append(header + seasonNumber)
        } else { textsForLabels.append("No Data") }
        
        if let episodeAirDate = episode.airDate {
            let header = "Air date: "
            textsForLabels.append(header + episodeAirDate)
        } else { textsForLabels.append("No Data") }
        
        if let episodeNumber = episode.episode {
            let header = "Episode number: "
            textsForLabels.append(header + episodeNumber)
        } else { textsForLabels.append("No Data") }
        
        if let serial = episode.series {
            let header = "Portrayed: "
            textsForLabels.append(header + serial)
        } else { textsForLabels.append("No Data") }
        
        view.showTitle(textsForLabels: textsForLabels)
    }
}
