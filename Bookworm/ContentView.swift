//
//  ContentView.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 09/11/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // @Query var books: [Book] // This version of the query does not specify any sorting
    
    // Query sorting can be done in two ways: a simple option that allows just one sort field:
    // @Query(sort: \Book.title) var books: [Book]
    // @Query(sort: \Book.rating, order: .reverse) var books: [Book]
    
    // And a more advanced version that allows an array of a new type called SortDescriptor:
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in // We don’t need to provide an identifier for the ForEach because all SwiftData models conform to Identifiable automatically.
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { selectedBook in
                DetailView(book: selectedBook)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddBookView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBookView) {
                AddBookView()
            }
        }
    }
}

#Preview {
    ContentView()
}
