//
//  TextEditorNotes.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 13/11/2025.
//

import SwiftUI

struct TextEditorNotes: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("TextField") {
                    TextFieldDemo()
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                NavigationLink("TextField Inside Form") {
                    Form {
                        TextFieldDemo()
                    }
                }
                
                NavigationLink("TextEditor") {
                    TextEditorDemo()
                        .padding()
                }
                
                NavigationLink("TextEditor Inside Form") {
                    Form {
                        TextEditorDemo()
                    }
                }
            }
            .navigationTitle("Text Inputs Demo")
        }
    }
}

struct TextEditorDemo: View {
    @AppStorage("Notes") private var notes = ""
    
    var body: some View {
        TextEditor(text: $notes)
    }
}

struct TextFieldDemo: View {
    @AppStorage("Notes") private var notes = ""
    
    var body: some View {
        TextField("TextField That Grows Vertically", text: $notes, axis: .vertical)
    }
}

// You'll use both of these approaches at some point, but at different times. While I love the way TextField automatically expands, sometimes it's just helpful to be able to show a large text space to your user so they know up front they can type a lot in there.

#Preview {
    TextEditorNotes()
}
