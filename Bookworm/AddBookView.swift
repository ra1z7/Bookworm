//
//  AddBookView.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 28/11/2025.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    let allGenres = ["Fantasy", "Horror", "Kids", "Poetry", "Romance", "Thriller", "Mystery"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Author Name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(allGenres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write A Review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating, label: "Rating")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
