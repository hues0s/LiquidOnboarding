//
//  HomeView.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 27/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var text: String = ""
    let finalText: String = "Welcome!"
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Text(text)
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
        .onAppear {
            typeWriter()
        }
    }
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                text.append(finalText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
