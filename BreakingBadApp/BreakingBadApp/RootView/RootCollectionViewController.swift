//
//  RootCollectionViewController.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 27.07.2022.
//

import UIKit

class RootCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var presenter: RootCollectionVCPresenterProtocol!
    private var userActions = UserActions.allCases
    private let transition = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RootCollectionVCPresenter(view: self, userActions: userActions)
        collectionView.backgroundColor = .white
        // Регистрация класса ячейки
        self.collectionView!.register(RootCollectionViewCell.self, forCellWithReuseIdentifier: RootCollectionViewCell.cellIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootCollectionViewCell.cellIdentifier, for: indexPath) as! RootCollectionViewCell
        cell.userAction = presenter.getUseAction(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32.0, height: 100)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presenter.currentUserAction(at: indexPath) {
        case .showCharacters:
            let NavVC = UINavigationController(rootViewController: StartTableViewController())
            NavVC.modalPresentationStyle = .fullScreen
            NavVC.transitioningDelegate = self.transition
            present(NavVC, animated: true)
        case .showEpisodes:
            let NavVC = UINavigationController(rootViewController: EpisodesTableViewController())
            NavVC.modalPresentationStyle = .fullScreen
            NavVC.transitioningDelegate = self.transition
            present(NavVC, animated: true)
        case .randomCharacter:
            break
        case .quotes:
            break
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let delay = indexPath.item
        let x = cell.frame.origin.x
        if indexPath.item % 2 == 0 {
            cell.frame.origin.x -= view.frame.maxX
        } else {
            cell.frame.origin.x += view.frame.maxX
        }
        UIView.animate( withDuration: 0.4, delay: TimeInterval(delay) * 0.4, options: []) {
            cell.frame.origin.x = x
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
