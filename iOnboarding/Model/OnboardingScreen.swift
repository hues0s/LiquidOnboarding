//
//  OnboardingScreen.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct OnboardingScreen: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var pic: String
    var color: Color
    var offset: CGSize = .zero
}
