//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 09/11/2025.
//

import SwiftData
import SwiftUI

@main // it acts as the launch pad for the whole app we're running.
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup { // tells SwiftUI that our app can be displayed in many windows. This doesn't do much on iPhone, but on iPad and macOS it becomes a lot more important.
            ContentView()
        }
        // Step 2: loading that model. This code will tell SwiftData to prepare some storage for us on the iPhone, which is where it will read and write Student objects.
        .modelContainer(for: Student.self)
        // A model container is SwiftData's name for where it stores its data. The first time your app runs this means SwiftData has to create the underlying database file, but in future runs, it will load the database it made previously.
    }
}
