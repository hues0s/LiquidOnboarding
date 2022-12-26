//
//  Home.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var onboardingScreens: [OnboardingScreen] = [
    
        OnboardingScreen(title: "Plan", subTitle: "your routes", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color("Green")),
        OnboardingScreen(title: "Quick Waste", subTitle: "Transfer Note", description: "Record oil collections easily and accurately. No more paper!", pic: "Pic2", color: Color("Purple")),
        OnboardingScreen(title: "Invite", subTitle: "restaurants", description: "Know some restaurant who want to optimize oil collection? Invite them with one click", pic: "Pic3", color: Color("Red"))
        
    ]
    
    @GestureState var isDragging: Bool = false
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(onboardingScreens.indices.reversed(), id: \.self) { index in
                
                OnboardingView(onboardingScreen: onboardingScreens[index])
                    .clipShape(LiquidShape(offset: onboardingScreens[index].offset, curvePoint: currentIndex == index ? 50 : 0))
                    .padding(.trailing, currentIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingScreens.count, id: \.self) { index in
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.15 : 0.85)
                        .opacity(currentIndex == index ? 1 : 0.25)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
            }
            .padding()
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .overlay(
            
            Button(action: {
                
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
                    .gesture(
                        
                        DragGesture()
                            .updating($isDragging, body: { value, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    onboardingScreens[currentIndex].offset = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    
                                    if -onboardingScreens[currentIndex].offset.width > getRect().width / 2 {
                                        onboardingScreens[currentIndex].offset.width = -getRect().height * 1.5
                                        
                                        currentIndex += 1
                                    } else {
                                        onboardingScreens[currentIndex].offset = .zero
                                    }
                                    
                                }
                            })
                    )
            })
            .offset(y: 53)
            .opacity(isDragging ? 0 : 1)
            .animation(.linear, value: isDragging)
            
            ,alignment: .topTrailing
            
        )
    }
    
    @ViewBuilder
    func OnboardingView(onboardingScreen: OnboardingScreen) -> some View {
        
        VStack {
            
            Image(onboardingScreen.pic)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(onboardingScreen.title)
                    .font(.system(size: 45))
                
                Text(onboardingScreen.subTitle)
                    .font(.system(size: 50, weight: .bold))
                
                Text(onboardingScreen.description)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100)
                    .lineSpacing(8)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            onboardingScreen.color
            
        )

        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
