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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingMissingFieldAlert = false
    @State private var showingButtonsForAuthor = false
    
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
                        if validateInput() {
                            saveBook()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert(errorTitle, isPresented: $showingMissingFieldAlert) {
                if showingButtonsForAuthor {
                    Button("No", role: .cancel) { }
                    Button("Yes", role: .confirm) {
                        saveBook()
                    }
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func validateInput() -> Bool {
        if title.isEmpty {
            errorTitle = "Missing Title"
            errorMessage = "Please enter book title to save it."
            showingMissingFieldAlert = true
            return false
        }
        
        if author.isEmpty {
            errorTitle = "Missing Author Name"
            errorMessage = "You didn't entered author's name. Save it as Anonymous?"
            showingButtonsForAuthor = true
            showingMissingFieldAlert = true
            return false
        }
        
        return true
    }
    
    func saveBook() {
        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
        modelContext.insert(newBook)
        dismiss()
    }
}

#Preview {
    AddBookView()
}
