//
//  RootCollectionViewCellPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 31.07.2022.
//

import Foundation

protocol RootCollectionViewCellPresenterProtocol {
    func setUpItemLabelText()
    init(view: RootCollectionViewCellProtocol, userAction: UserActions)
}

final class RootCollectionViewCellPresenter {
    
    unowned let view: RootCollectionViewCellProtocol
    let userAction: UserActions
    
    init(view: RootCollectionViewCellProtocol, userAction: UserActions) {
        self.view = view
        self.userAction = userAction
    }
}

extension RootCollectionViewCellPresenter: RootCollectionViewCellPresenterProtocol {
    func setUpItemLabelText() {
        view.setLabelText(text: userAction.rawValue)
    }
}


