//
//  ContentView.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 09/11/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var books: [Book]
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
