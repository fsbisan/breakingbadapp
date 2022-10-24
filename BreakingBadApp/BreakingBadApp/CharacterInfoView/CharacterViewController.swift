//
//  CharacterViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 26.07.2022.
//

import UIKit

protocol CharacterViewControllerProtocol {
    func showImage(from data: Data)
    func showLabelsText(from string: [String])
    func showErrorImage()
}

class CharacterViewController: UIViewController {
    
    var character: Character! {
        didSet {
            presenter = CharacterViewControllerPresenter(view: self,
                                                         character: self.character)
            presenter.setUpImage()
            presenter.setupLabelsText()
        }
    }
    
    var presenter: CharacterInfoViewControllerPresenterProtocol!
    
    let fontSize: CGFloat = 14
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .systemGray
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        return spinnerView
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var birthDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var appearanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var portrayedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var betterCallSaulAppearanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupSubviews(
            characterImageView, nameLabel, categoryLabel,
            birthDayLabel, occupationLabel, statusLabel,
            nickNameLabel, appearanceLabel, portrayedLabel,
            betterCallSaulAppearanceLabel, spinnerView
        )
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "episodes",
            style: .plain,
            target: self,
            action: #selector(goToEpisodesTableView)
        )
    }
    
    @objc private func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut
        )
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: true)
    }
    
    @objc func goToEpisodesTableView() {
        let episodeVC = EpisodesTableViewController()
        episodeVC.character = character.name
        let episodeNavContrVC = UINavigationController(rootViewController: episodeVC)
        episodeNavContrVC.modalPresentationStyle = .fullScreen
        present(episodeNavContrVC, animated: true)
    }
    
    private func setConstraints() {
        
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayLabel.translatesAutoresizingMaskIntoConstraints = false
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appearanceLabel.translatesAutoresizingMaskIntoConstraints = false
        portrayedLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        betterCallSaulAppearanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                    constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                       multiplier: 0.4 ),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor,
                                                      multiplier: 2 / 3),
            
            spinnerView.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: 20),
            spinnerView.widthAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor,
                                           constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -10),
            
            birthDayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                               constant: 5),
            birthDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 10),
            birthDayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -10),
            
            occupationLabel.topAnchor.constraint(equalTo: birthDayLabel.bottomAnchor,
                                                 constant: 5),
            occupationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 10),
            occupationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -10),
            
            statusLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor,
                                             constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -10),
            
            nickNameLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor,
                                               constant: 5),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 10),
            nickNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -10),
            
            appearanceLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor,
                                                 constant: 5),
            appearanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 10),
            appearanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -10),
            
            portrayedLabel.topAnchor.constraint(equalTo: appearanceLabel.bottomAnchor,
                                                constant: 5),
            portrayedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 10),
            portrayedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -10),
            
            categoryLabel.topAnchor.constraint(equalTo: portrayedLabel.bottomAnchor,
                                               constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            betterCallSaulAppearanceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor,
                                                               constant: 5),
            betterCallSaulAppearanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                   constant: 10),
            betterCallSaulAppearanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                    constant: -10),
        ])
    }
}

extension CharacterViewController: CharacterViewControllerProtocol {
    func showImage(from data: Data) {
        guard let image = UIImage(data: data) else { return }
        characterImageView.image = image
        spinnerView.stopAnimating()
    }
    
    func showErrorImage() {
        characterImageView.image = UIImage(named: "garryPotter")
    }
    
    func showLabelsText(from string: [String]) {
        self.title = string[0]
        nameLabel.text = string[1]
        birthDayLabel.text = string[2]
        occupationLabel.text = string[3]
        statusLabel.text = string[4]
        nickNameLabel.text = string[5]
        appearanceLabel.text = string[6]
        portrayedLabel.text = string[7]
        categoryLabel.text = string[8]
        betterCallSaulAppearanceLabel.text = string[9]
    }
}
