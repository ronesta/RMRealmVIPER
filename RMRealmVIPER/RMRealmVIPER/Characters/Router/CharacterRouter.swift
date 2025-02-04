//
//  CharacterRouter.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation
import UIKit

final class CharacterRouter: CharacterRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let storageManager = StorageManager()
        let networkManager = NetworkManager()

        let view = CharacterViewController()
        let dataSource = CharacterTableViewDataSource(
            networkManager: networkManager,
            storageManager: storageManager
        )
        let presenter = CharacterPresenter()
        let interactor = CharacterInteractor()
        let router = CharacterRouter()

        view.presenter = presenter
        view.dataSource = dataSource

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.presenter = presenter
        interactor.storageManager = storageManager
        interactor.networkManager = networkManager

        router.viewController = view

        return view
    }
}
