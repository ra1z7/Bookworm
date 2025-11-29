//
//  RatingView.swift
//  Bookworm
//
//  Created by Purnaman Rai (College) on 29/11/2025.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label: String?
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if let label {
                Text(label)
                Spacer()
            }
            
            ForEach(1 ..< maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        // No matter which star rating you press, it will select 5 stars when used with Form because when we have rows inside a form or a list, SwiftUI likes to assume the rows themselves are tappable. This makes selection easier for users, because they can tap anywhere in a row to trigger the button inside it.
        
        // In our case we have multiple buttons, so SwiftUI is tapping them all in order – rating gets set to 1, then 2, then 3, 4, and 5, which is why it ends up at 5 no matter what.
        
        // We can disable "tap the row to trigger its buttons" behavior with an extra modifier attached to the whole HStack:
        .buttonStyle(.plain) // Makes SwiftUI treat each button individually
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

// When our #Preview code doesn’t pass in a binding to use for rating, we'll get an error. SwiftUI has a specific and simple solution for this called constant bindings. These are bindings that have fixed values, which on the one hand means they can’t be changed in the UI, but also means we can create them trivially – they are perfect for previews.
#Preview {
    RatingView(rating: .constant(3))
}
