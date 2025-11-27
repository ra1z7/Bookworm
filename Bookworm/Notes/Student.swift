//
//  Student.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 26/11/2025.
//

// Step 1: defining the data we want to use in our app
// We can turn regular Student class into a SwiftData object – something that it can save in its database, sync with iCloud, search, sort, and more. Import SwiftData framework, then add @Model macro to that class. Now this class is called a SwiftData model: it defines some kind of data we want to work with in our apps. Behind the scenes, @Model builds on top of the same observation system that @Observable uses, which means it works really well with SwiftUI.

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
