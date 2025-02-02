//
//  RealmCharacter.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import RealmSwift

final class RealmCharacter: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var imageData: Data?

    override static func primaryKey() -> String? {
        return "id"
    }
}
