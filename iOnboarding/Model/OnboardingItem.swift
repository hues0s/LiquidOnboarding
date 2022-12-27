//
//  OnboardingScreen.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var color: Color
    var offset: CGSize = .zero
    var lottieView: LottieAnimationView = .init()
}
