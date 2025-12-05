//
//  DetailView.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 30/11/2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book // Adding this property breaks the DetailView preview because creating a sample Book now requires a SwiftData model context.
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)
                    .padding(10)
            }
            
            Text(book.author)
                .font(.title)
                .fontWeight(.bold)
            
            Text(book.review.isEmpty ? "No Review Written" : book.review)
                .padding()
                .foregroundStyle(book.review.isEmpty ? Color.secondary : Color.primary)
            
            RatingView(rating: .constant(book.rating)) // We don’t want users to be able to adjust the rating here, so instead we can use constant binding to turn this into a simple read-only view.
                .font(.title)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        // Apple provides very clear guidance on how we should label alert text, but it comes down to this: if it’s a simple “I understand” acceptance then “OK” is good, but if you want users to make a choice then you should avoid titles like “Yes” and “No” and instead use verbs such as “Ignore”, “Reply”, and “Confirm”. In this instance, we’re going to use “Delete” for the destructive button, then provide a "Cancel" button next to it so users can back out of deleting if they want.
        .alert("Delete This Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are You Sure?")
        }
        .toolbar {
            Button("Delete This Book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        // A SwiftData object (a Book) is designed to live inside a database (a ModelContainer). If you try to create a Book and use it in a Preview without a database running in the background, Xcode will crash or fail to build. The main app creates the database in BookwormApp.swift. But the Preview is a separate, isolated island; it doesn't know about the main app's database. To make the Preview work, we have to build a temporary, throw-away database just for the Preview canvas.
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // I want to make a database, but don't save it to the actual iPhone disk. Just keep it in RAM (memory). When the preview closes, delete it.
        let container = try ModelContainer(for: Book.self, configurations: config) // Build the actual database engine using the 'Memory Only' settings I just created. This database will hold Book objects.
        let exampleBook = Book(title: "Test Book Title", author: "Test Author Name", genre: "Mystery", review: "It was a great book! I loved it.", rating: 4) // Yes, creating the Book instance doesn't actually mention the model container or configuration anywhere, but it does matter: trying to create a SwiftData model object without a container around is likely to make your code crash.
        
        return DetailView(book: exampleBook)
            .modelContainer(container)
    } catch {
        return Text("Failed To Load Preview: \(error.localizedDescription)")
    }
}
