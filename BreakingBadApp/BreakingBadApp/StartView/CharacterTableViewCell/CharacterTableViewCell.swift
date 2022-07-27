//
//  CharacterTableViewCell.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import UIKit

protocol CharacterTableViewCellProtocol: AnyObject {
    func showImage(data: Data)
    func showName(characterName: String)
}

class CharacterTableViewCell: UITableViewCell {
    
    static var cellIdentifier = "CharacterTableViewCell"
    
    
    var presenter: CharacterTableViewCellPresenterProtocol!
    var character: Character? {
        didSet {
            presenter = CharacterTableViewCellPresenter(view: self, character: character)
            presenter.setImage()
            presenter.setName()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(characterImageView, nameOfCharacterLabel, spinnerView)
        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .systemGray
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        return spinnerView
    }()
    
    private lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .white
        return image
    }()

    private lazy var nameOfCharacterLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
   
    private func setConstraints() {
        
        nameOfCharacterLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            characterImageView.widthAnchor.constraint(equalToConstant: 70),
            
            spinnerView.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: 20),
            spinnerView.widthAnchor.constraint(equalToConstant: 20),
            
            nameOfCharacterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameOfCharacterLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            nameOfCharacterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5)
        ])
    }
}

extension CharacterTableViewCell: CharacterTableViewCellProtocol {
    func showName(characterName: String) {
        nameOfCharacterLabel.text = characterName
    }
    
    func showImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        characterImageView.image = image
        spinnerView.stopAnimating()
    }
}
