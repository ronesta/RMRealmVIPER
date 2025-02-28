//
//  CharacterRouter.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation
import UIKit.UIViewController

final class CharacterRouter: CharacterRouterProtocol {
    weak var viewController: UIViewController?

    func createModule() -> UIViewController {
        let storageManager = StorageManager()
        let networkManager = NetworkManager()

        let presenter = CharacterPresenter()
        let dataSource = CharacterTableViewDataSource(presenter: presenter)
        let router = CharacterRouter()

        let interactor = CharacterInteractor(presenter: presenter,
                                             networkManager: networkManager,
                                             storageManager: storageManager
        )

        let view = CharacterViewController(presenter: presenter,
                                           dataSource: dataSource
        )

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        router.viewController = view

        return view
    }
}
