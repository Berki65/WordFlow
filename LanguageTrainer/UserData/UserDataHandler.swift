//
//  UserDataHandler.swift
//  KoreanApp
//
//  Created by Berkay Bentetik on 05.12.24.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
