//
//  OnboardingCarousel.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

struct OnboardingCarousel: View {
    
    @Environment(\.dismiss) var dismiss
    
    struct OnboardingContent: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let showDismiss: Bool
    }
    
    private var onboardingContent = [
        OnboardingContent(
            title: "Hello 👋",
            description: "Welcome to Cnotta!",
            showDismiss: false
        ),
        OnboardingContent(
            title: "Getting Started",
            description: "Tracking your knitting projects is easy with Cnotta. Just create the project, choose a fun color, and go!",
            showDismiss: false
        ),
        OnboardingContent(
            title: "Counting",
            description: "Tap the + and - buttons to count your rows.\n\nIf you need to reset, hold the - button for a while and it will go back to zero!",
            showDismiss: true
        )
    ]
    
    var body: some View {
        TabView {
            ForEach(onboardingContent) { page in
                VStack {
                    Text(page.title)
                        .font(.title)
                        .foregroundStyle(Color.fromHexCode(0x0b2134))
                    
                    Spacer().frame(height: 16)
                    
                    Text(page.description)
                        .font(.body)
                        .foregroundStyle(Color.fromHexCode(0x004a80))
                    
                    if page.showDismiss {
                        Spacer().frame(height: 32)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Get Started!")
                        }
                        .foregroundStyle(Color.fromHexCode(0x0072bc))
                        .padding(16)
                        .glassEffect()
                    }
                }
                .padding(32)
            }
        }
        .background(Color.fromHexCode(0xc4d3ed))
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnboardingCarousel()
}
