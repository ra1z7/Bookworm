//
//  Student.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 26/11/2025.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
