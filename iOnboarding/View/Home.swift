//
//  Home.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct Home: View {
    
    @State var onboardingScreens: [OnboardingScreen] = [
    
        OnboardingScreen(title: "Plan", subTitle: "your routes", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color("Green")),
        OnboardingScreen(title: "Quick Waste", subTitle: "Transfer Note", description: "Record oil collections easily and accurately. No more paper!", pic: "Pic2", color: Color("Purple")),
        OnboardingScreen(title: "Invite", subTitle: "restaurants", description: "Know some restaurant who want to optimize oil collection? Invite them with one click", pic: "Pic3", color: Color("Red"))
        
    ]
    
    @GestureState var isDragging: Bool = false
    @State var fakeIndex: Int = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(onboardingScreens.indices.reversed(), id: \.self) { index in
                
                OnboardingView(onboardingScreen: onboardingScreens[index])
                    .clipShape(LiquidShape(offset: onboardingScreens[index].offset, curvePoint: fakeIndex == index ? 50 : 0))
                    .padding(.trailing, fakeIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingScreens.count, id: \.self) { index in
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(fakeIndex == index ? 1.15 : 0.85)
                        .opacity(fakeIndex == index ? 1 : 0.25)
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
                                    onboardingScreens[fakeIndex].offset = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    
                                    if -onboardingScreens[fakeIndex].offset.width > getRect().width / 2 {
                                        onboardingScreens[fakeIndex].offset.width = -getRect().height * 1.5
                                        
                                        fakeIndex += 1
                                    } else {
                                        onboardingScreens[fakeIndex].offset = .zero
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
//        .onAppear {
//
//            guard let first = onboardingScreens.first else {
//                return
//            }
//
//            guard var last = onboardingScreens.last else {
//                return
//            }
//
//            last.offset.width = -getRect().height * 1.5
//
//            onboardingScreens.append(first)
//            onboardingScreens.insert(last, at: 0)
//
//            fakeIndex = 1
//
//        }
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct LiquidShape: Shape {
    
    var offset: CGSize
    var curvePoint: CGFloat
    
    var animatableData: AnimatablePair<CGSize.AnimatableData, CGFloat> {
        get {
            return AnimatablePair(offset.animatableData, curvePoint)
        }
        set {
            offset.animatableData = newValue.first
            curvePoint = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let from = 80 + offset.width
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + offset.height - offset.width
            to = to < 180 ? 180 : to
            
            let mid: CGFloat = 80 + ((to - 80) / 2)
            
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - curvePoint, y: mid), control2: CGPoint(x: width - curvePoint, y: mid))
        }
    }
    
}
