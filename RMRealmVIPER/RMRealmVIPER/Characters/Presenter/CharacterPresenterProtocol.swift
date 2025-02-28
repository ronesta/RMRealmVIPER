//
//  CharacterPresenterProtocol.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation

protocol CharacterPresenterProtocol: AnyObject {
    func viewDidLoad()

    func charactersFetched(_ characters: [RealmCharacter])

    func charactersFetchFailed(with error: Error)

    func fetchImageData(for characterId: Int) -> Data?
}
