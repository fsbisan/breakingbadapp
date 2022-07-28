//
//  EpisodesTableViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import UIKit

protocol EpisodesTableViewControllerProtocol: AnyObject {
    func showLabelsText(from string: [String])
}

class EpisodesTableViewController: UITableViewController {

    var episodesList: [Episode] = []
    var character: String?
    var presenter: EpisodesTableVCPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.cellIdentifier)
        presenter = EpisodesTableVCPresenter(view: self, episodes: episodesList, characterName: character)
        presenter.getEpisodesList()
        view.backgroundColor = .white
        tableView.rowHeight = 50
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.cellIdentifier, for: indexPath) as! EpisodeTableViewCell
        cell.episode = presenter.getEpisode(at: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension EpisodesTableViewController: EpisodesTableViewControllerProtocol {
    func showLabelsText(from string: [String]) {
    }
}
