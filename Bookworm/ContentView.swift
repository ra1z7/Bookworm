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
            Text("Book Count: \(books.count)")
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
