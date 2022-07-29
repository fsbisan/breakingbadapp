//
//  EpisodeInfoViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 28.07.2022.
//

import UIKit

protocol EpisodeInfoVCProtocol: AnyObject {
    func showTitle(textsForLabels: [String])
    var tableView: UITableView { get }
}

class EpisodeInfoViewController: UIViewController {
    
    var presenter: EpisodeInfoVCPresenterProtocol!
    var characters: [Character] = []
    var episode: Episode! {
        didSet {
            presenter = EpisodeInfoVCPresenter(view: self,
                                               episode: episode,
                                               characters: characters)
            presenter.setLabelsTexts()
            presenter.getCharacterFromEpisode()
        }
    }
    
    private let fontSizeOfTopTitle: CGFloat = 24
    private let fontSizeOfInfoLabelsTexts: CGFloat = 20
    
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSizeOfTopTitle)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var seasonNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSizeOfInfoLabelsTexts)
        return label
    }()
    
    private lazy var airDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSizeOfInfoLabelsTexts)
        return label
    }()
    
    private lazy var numberOfEpisodeInSeasonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSizeOfInfoLabelsTexts)
        return label
    }()
    
    private lazy var serialNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSizeOfInfoLabelsTexts)
        return label
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        tableView.rowHeight = 100
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        setupSubviews(
            topTitleLabel, seasonNumberLabel, numberOfEpisodeInSeasonLabel,
            airDateLabel, serialNameLabel, tableView
        )
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    @objc private func closeView() {
        dismiss(animated: true)
    }
    
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
    
    private func setConstraints() {
        
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        seasonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfEpisodeInSeasonLabel.translatesAutoresizingMaskIntoConstraints = false
        airDateLabel.translatesAutoresizingMaskIntoConstraints = false
        serialNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 16),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 16),
            topTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -16),
            
            seasonNumberLabel.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor,
                                                   constant: 10),
            seasonNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: 16),
            seasonNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                        constant: -16),
            
            numberOfEpisodeInSeasonLabel.topAnchor.constraint(equalTo: seasonNumberLabel.bottomAnchor,
                                                              constant: 5),
            numberOfEpisodeInSeasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                  constant: 16),
            numberOfEpisodeInSeasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                   constant: -16),
            
            airDateLabel.topAnchor.constraint(equalTo: numberOfEpisodeInSeasonLabel.bottomAnchor,
                                              constant: 5),
            airDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: 16),
            airDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -16),
            
            serialNameLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor,
                                                 constant: 5),
            serialNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 16),
            serialNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -16),
            
            tableView.topAnchor.constraint(equalTo: serialNameLabel.bottomAnchor,
                                           constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EpisodeInfoViewController: EpisodeInfoVCProtocol, UITableViewDataSource {
    
    func showTitle(textsForLabels: [String]) {
        topTitleLabel.text = textsForLabels[0]
        seasonNumberLabel.text = textsForLabels[1]
        airDateLabel.text = textsForLabels[2]
        numberOfEpisodeInSeasonLabel.text = textsForLabels[3]
        serialNameLabel.text = textsForLabels[4]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        cell.character = presenter.getCharacter(at: indexPath)
        return cell
    }
}
