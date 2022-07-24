//
//  StartViewControllerPresenter.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation
protocol CharacterViewControllerPresenterProtocol {
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterTableViewCellPresenterProtocol
}

class CharacterStarViewControllerPresenter: CharacterViewControllerPresenterProtocol {
    func numberOfRows() -> Int {
        <#code#>
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterTableViewCellPresenterProtocol {
        <#code#>
    }
    
    
}
