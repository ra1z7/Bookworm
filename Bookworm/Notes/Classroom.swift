//
//  Classroom.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 26/11/2025.
//

import SwiftData
import SwiftUI

struct Classroom: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
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
