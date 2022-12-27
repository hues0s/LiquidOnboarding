//
//  HomeView.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 27/12/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Text("Welcome!")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
