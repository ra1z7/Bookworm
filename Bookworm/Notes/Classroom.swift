//
//  Classroom.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 26/11/2025.
//

import SwiftData
import SwiftUI

struct Classroom: View {
    // Step 3: The model context, which is effectively the “live” version of your data – when you load objects and change them, those changes only exist in memory until they are saved. So, the job of the model context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk. It's created automatically when we use the modelContainer() modifier in step 2.
    
    @Query var students: [Student] // Retrieving information from SwiftData is done using a query – we describe what we want, how it should be sorted, and whether any filters should be used, and SwiftData sends back all the matching data. Just adding @Query to the start is enough to make SwiftData load students from its model container – it automatically finds the main context that was placed into the environment, and queries the container through there. We haven't specified which students to load, or how to sort the results, so we'll just get all of them.
    
    @Environment(\.modelContext) var modelContext // Just like SwiftUI lets us read values such as color scheme or size classes from the environment, SwiftData places the model context there automatically so our views can access it whenever they need to read, create, or modify data. By using @Environment to pull out \.modelContext, we're effectively tapping into the shared data workspace that SwiftData manages for us – this is the same context used by our @Query above, and it's where all inserts, deletes, and saves happen.
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Alice", "Bob", "Charlie", "Diego", "Ethan"]
                    let lastNames = ["Rai", "Tamang", "Khatri", "Chaulagain", "Sherpa"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    Classroom()
}
