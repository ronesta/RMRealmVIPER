//
//  CharacterPresenter.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation

final class CharacterPresenter: CharacterPresenterProtocol {
    weak var view: CharacterViewProtocol?
    var interactor: CharacterInteractorProtocol?
    var router: CharacterRouterProtocol?

    func viewDidLoad() {
        interactor?.getCharacters()
    }

    func charactersFetched(_ characters: [RealmCharacter]) {
        view?.displayCharacters(characters)
    }

    func charactersFetchFailed(with error: Error) {
        view?.displayError("Failed to load characters: \(error.localizedDescription)")
    }
}
