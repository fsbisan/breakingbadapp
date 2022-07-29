//
//  StartTableViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import UIKit

class StartTableViewController: UITableViewController {
    
    var charactersList: [Character] = []
    var presenter: CharacterViewControllerPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        presenter = CharacterStarViewControllerPresenter(characters: charactersList, view: self)
        presenter.getCharacterList()
        view.backgroundColor = .white
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        cell.character = presenter.getCharacter(at: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterVC = CharacterViewController()
        characterVC.character = presenter.getCharacter(at: indexPath)
        let characterNavContrVC = UINavigationController(rootViewController: characterVC)
        characterNavContrVC.modalPresentationStyle = .fullScreen
        present(characterNavContrVC, animated: true)
    }
}
