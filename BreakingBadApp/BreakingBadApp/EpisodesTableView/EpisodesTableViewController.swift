//
//  EpisodesTableViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import UIKit

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
        setupNavigationBar()
        tableView.rowHeight = 50
    }

    // MARK: - Table view data source

    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "back",
            style: .plain,
            target: self,
            action: #selector(closeView)
            )
    }
    
    @objc private func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.cellIdentifier, for: indexPath) as! EpisodeTableViewCell
        cell.episode = presenter.getEpisode(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeInfoVC = EpisodeInfoViewController()
        episodeInfoVC.episode = presenter.getEpisode(at: indexPath)
        let epsiodeNavContrVC = UINavigationController(rootViewController: episodeInfoVC)
        epsiodeNavContrVC.modalPresentationStyle = .fullScreen
        present(epsiodeNavContrVC, animated: true)
    }
}
