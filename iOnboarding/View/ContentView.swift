//
//  ContentView.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentIndex: Int = 0
    @State var onboardingItems: [OnboardingItem] = [
    
        .init(title: "Request Pickup", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", color: Color("Green"), lottieView: .init(name: "Pickup", bundle: .main)),
        .init(title: "Track Delivery", subTitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications of his exact location", color: Color("Orange"), lottieView: .init(name: "Delivery", bundle: .main)),
        .init(title: "Receive Package", subTitle: "The journey ends when your package get to it's locations. Get notified immediately when you package is received at its intended location", color: Color("Blue"), lottieView: .init(name: "Receive", bundle: .main))
        
    ]
    
    var body: some View {
        if currentIndex > onboardingItems.count - 1 {
            HomeView()
        } else {
            OnboardingView(onboardingItems: $onboardingItems, currentIndex: $currentIndex)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
