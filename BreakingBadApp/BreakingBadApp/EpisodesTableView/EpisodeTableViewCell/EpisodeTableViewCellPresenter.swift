//
//  EpisodeTableViewCellPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import Foundation

protocol EpisodeTableViewCellPresenterProtocol {
    init(view: EpisodeTableViewCellProtocol, episode: Episode?)
    func setName()
}

class EpisodeTableViewCellPresenter {

    unowned private let view: EpisodeTableViewCellProtocol
    private let episode: Episode?
    
    required init(view: EpisodeTableViewCellProtocol, episode: Episode?) {
        self.view = view
        self.episode = episode
    }
}

extension EpisodeTableViewCellPresenter: EpisodeTableViewCellPresenterProtocol {
    
    func setName() {
        guard let episode = episode else { return }
        guard let title = episode.title else { return }
        view.showEpisodeTitle(title)
    }
}
