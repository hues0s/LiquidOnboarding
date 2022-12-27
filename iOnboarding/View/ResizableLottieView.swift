//
//  ResizableLottieView.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 27/12/22.
//

import SwiftUI

struct ResizableLottieView: UIViewRepresentable {
    
    var onboardingItem: OnboardingItem
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setUpLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setUpLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        to.addSubview(lottieView)
        lottieView.widthAnchor.constraint(equalTo: to.widthAnchor).isActive = true
        lottieView.heightAnchor.constraint(equalTo: to.heightAnchor).isActive = true
    }
}
