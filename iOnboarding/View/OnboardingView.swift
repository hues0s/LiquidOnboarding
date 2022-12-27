//
//  Home.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var onboardingItems: [OnboardingItem]
    @GestureState var isDragging: Bool = false
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ForEach(onboardingItems.indices.reversed(), id: \.self) { index in
                
                OnboardingView(onboardingItem: onboardingItems[index], itemIndex: index)
                    .clipShape(LiquidShape(offset: onboardingItems[index].offset, curvePoint: currentIndex == index ? 50 : 0))
                    .padding(.trailing, currentIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingItems.count, id: \.self) { index in
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.15 : 0.85)
                        .opacity(currentIndex == index ? 1 : 0.25)
                }
                
                Spacer()
                
                Button {
                    currentIndex = onboardingItems.count
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
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
                    .foregroundColor(currentIndex == onboardingItems.count - 1 ? .white: .black)
                    .contentShape(Rectangle())
                    .gesture(
                        
                        DragGesture()
                            .updating($isDragging, body: { value, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    onboardingItems[currentIndex].offset = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    
                                    if -onboardingItems[currentIndex].offset.width > getRect().width / 2 {
                                        onboardingItems[currentIndex].offset.width = -getRect().height * 1.5
                                        
                                        currentIndex += 1
                                    } else {
                                        onboardingItems[currentIndex].offset = .zero
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
    func OnboardingView(onboardingItem: OnboardingItem, itemIndex: Int) -> some View {
        VStack {
            
            Spacer()
            ResizableLottieView(onboardingItem: onboardingItem)
                .frame(maxWidth: 340, maxHeight: 340)
                .onAppear {
                    onboardingItem.lottieView.loopMode = .loop
                    onboardingItem.lottieView.play()
                }
                
            VStack(spacing: 20) {
                
                Text(onboardingItem.title)
                    .font(.title.bold())
                
                Text(onboardingItem.subTitle)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 7)
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Terms of Service")
                            .font(.system(size: 11))
                            .underline(true, color: .black)
                            .padding(.trailing, 5)
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Privacy Policy")
                            .font(.system(size: 11))
                            .underline(true, color: .black)
                            .padding(.leading, 5)
                    })
                }
                .padding(.top, 15)
                
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 30)
            .padding(.trailing)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(onboardingItem.color)
        
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingItems: .constant([OnboardingItem]()), currentIndex: .constant(0))
    }
}
