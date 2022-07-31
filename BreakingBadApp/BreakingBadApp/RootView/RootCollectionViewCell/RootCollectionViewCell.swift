//
//  RootCollectionViewCell.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 31.07.2022.
//

import UIKit

protocol RootCollectionViewCellProtocol: AnyObject {
    func setLabelText(text: String)
}

class RootCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RootCollectionViewCell"
    
    var presenter: RootCollectionViewCellPresenterProtocol!
    
    var userAction: UserActions! {
        didSet {
            presenter = RootCollectionViewCellPresenter(view: self, userAction: userAction)
            presenter.setUpItemLabelText()
        }
    }
    
    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemMint
        contentView.layer.cornerRadius = 15
        setupSubviews(itemLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            itemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

extension RootCollectionViewCell: RootCollectionViewCellProtocol {
    func setLabelText(text: String) {
        itemLabel.text = text
    }
}
