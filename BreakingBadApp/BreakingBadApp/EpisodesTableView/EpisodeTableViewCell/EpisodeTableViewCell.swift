//
//  EpisodeTableViewCell.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import UIKit

protocol EpisodeTableViewCellProtocol: AnyObject {
    func showEpisodeTitle(_ title: String)
}

class EpisodeTableViewCell: UITableViewCell {
    static var cellIdentifier = "EpisodeTableViewCell"
    
    var presenter: EpisodeTableViewCellPresenterProtocol!
    var episode: Episode? {
        didSet {
            presenter = EpisodeTableViewCellPresenter(view: self, episode: episode)
            presenter.setName()
        }
    }
    
    private lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .systemGray
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        return spinnerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(episodeTitleLabel, spinnerView)
        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        episodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            episodeTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            episodeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            episodeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            spinnerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spinnerView.widthAnchor.constraint(equalToConstant: 30),
            spinnerView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension EpisodeTableViewCell: EpisodeTableViewCellProtocol {
    func showEpisodeTitle(_ title: String) {
        episodeTitleLabel.text = title
        spinnerView.stopAnimating()
    }
}

