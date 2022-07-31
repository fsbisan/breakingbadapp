//
//  RootCollectionVCPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import Foundation

enum UserActions: String, CaseIterable {
    case showCharacters = "Show Characters"
    case showEpisodes = "Show Episodes"
    case randomCharacter = "Random Character"
    case quotes = "Quotes"
}

protocol RootCollectionVCPresenterProtocol {
    func numberOfItems() -> Int
    func getUseAction(at indexPath: IndexPath) -> UserActions
    func currentUserAction(at indexPath: IndexPath) -> UserActions
    init(view: RootCollectionViewController, userActions: [UserActions])
}

class RootCollectionVCPresenter {
    
    var userActions: [UserActions]
    let view: RootCollectionViewController
    
    required init(view: RootCollectionViewController, userActions: [UserActions]) {
        self.view = view
        self.userActions = userActions
    }
}

extension RootCollectionVCPresenter: RootCollectionVCPresenterProtocol {
    func currentUserAction(at indexPath: IndexPath) -> UserActions {
        userActions[indexPath.item]
    }
    
    func getUseAction(at indexPath: IndexPath) -> UserActions {
        userActions[indexPath.item]
    }
    
    func numberOfItems() -> Int {
        userActions.count
    }
}
