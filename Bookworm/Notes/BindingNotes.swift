//
//  BindingNotes.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 09/11/2025.
//

import SwiftUI

// @Bindable is used when you're accessing a shared class that uses the @Observable macro: You create it using @State in one view, so you have bindings available there, but you use @Bindable when sharing it with other views so SwiftUI can create bindings there too.

// On the other hand, @Binding is used when you have a simple, value type piece of data rather than a separate class. For example, you have an @State property that stores a Boolean, a Double, an array of strings, etc, and you want to pass that around. That doesn't use the @Observable macro, so we can't use @Bindable. Instead, we use @Binding, so we can share that Boolean or integer in several places.

struct PushButton: View {
    let title: String
//  @State var isOn: Bool
    @Binding var isOn: Bool
    
    var body: some View {
        Button(title) {
            withAnimation(.interactiveSpring) {
                isOn.toggle()
            }
        }
        .font(.system(size: 14, design: .monospaced))
        .foregroundStyle(.black)
        .frame(width: 140, height: 45)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.1)
        }
        .clipShape(.rect(cornerRadius: 5))
        .shadow(radius: isOn ? -2 : 0, x: -3, y: 3)
        .offset(x: isOn ? 0 : 3, y: isOn ? 0 : -3)
    }
}

struct BindingNotes: View {
    @State private var rememberMe = false
    
    var body: some View {
        VStack(spacing: 14) {
        //  PushButton(title: "Remember Me", isOn: rememberMe)
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "ON" : "OFF")
                .font(.caption)
                .contentTransition(.numericText())
                .foregroundStyle(rememberMe ? .green : .red)
        }
    }
}

#Preview {
    BindingNotes()
}

// REVIEW NOTES

// @Binding lets us share one struct in two places. It's mainly used for creating custom UI components.
// @Binding can be used with a private properties.
// @Binding is used for structs, but @Bindable is used for observable classes.

// SwiftData models are classes in Swift. They are designed to be shared, so making them as structs isn't allowed.

// Views presented as sheets doesn't share the same environment as the view that presented them. Views presented as sheets have their own environment, so if you want to share values you need to pass them in.
