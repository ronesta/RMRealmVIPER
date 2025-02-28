//
//  CharacterInteractor.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation

final class CharacterInteractor: CharacterInteractorProtocol {
    private let presenter: CharacterPresenterProtocol
    private let networkManager: NetworkManagerProtocol
    private let storageManager: StorageManagerProtocol

    init(presenter: CharacterPresenterProtocol,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func getCharacters() {
        let savedCharacters = storageManager.fetchCharacters()

        guard savedCharacters.isEmpty else {
            presenter.charactersFetched(savedCharacters)
            return
        }

        networkManager.getCharacters { [weak self] result, error in
            guard let self else {
                return
            }

            if let error {
                print("Error getting characters: \(error)")
                return
            }

            guard let result else {
                print("No result returned.")
                return
            }

            var charactersToSave: [(character: Character, imageData: Data)] = []

            let group = DispatchGroup()

            result.forEach { res in
                group.enter()
                self.networkManager.loadImage(from: res.image) { data, error in
                    defer {
                        group.leave()
                    }

                    if let error {
                        print("Failed to load image: \(error)")
                        return
                    }

                    guard let data else {
                        print("No data for image")
                        return
                    }

                    charactersToSave.append((character: res, imageData: data))
                }
            }

            group.notify(queue: .main) { [weak self] in
                guard let self else {
                    return
                }
                self.storageManager.saveCharacters(charactersToSave)

                DispatchQueue.main.async {
                    let fetchCharacters = self.storageManager.fetchCharacters()
                    self.presenter.charactersFetched(fetchCharacters)
                }
            }
        }
    }

    func getImageData(for characterId: Int) -> Data? {
        storageManager.fetchImageData(forCharacterId: characterId)
    }
}
