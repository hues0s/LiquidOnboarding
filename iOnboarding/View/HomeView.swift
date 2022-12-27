//
//  Home.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 24/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var onboardingItems: [OnboardingItem] = [
    
        .init(title: "Request Pickup", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", color: Color("Green"), lottieView: .init(name: "Pickup", bundle: .main)),
        .init(title: "Track Delivery", subTitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact locations of the courier", color: Color("Purple"), lottieView: .init(name: "Delivery", bundle: .main)),
        .init(title: "Receive Package", subTitle: "The journey ends when your package get to it's locations. Get notified immediately when you package is received at its intended location", color: Color("Red"), lottieView: .init(name: "Receive", bundle: .main))
        
    ]
    
    @GestureState var isDragging: Bool = false
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(onboardingItems.indices.reversed(), id: \.self) { index in
                
                OnboardingView(onboardingItem: onboardingItems[index], itemIndex: index)
                    .clipShape(LiquidShape(offset: onboardingItems[index].offset, curvePoint: currentIndex == index ? 50 : 0))
                    .padding(.trailing, currentIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingItems.count, id: \.self) { index in
                    
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
            ResizableLottieView(onboardingItem: onboardingItem)
                .onAppear {
                    if currentIndex == itemIndex {
                        onboardingItem.lottieView.loopMode = .loop
                        onboardingItem.lottieView.play()
                    }
                }
            
            VStack(spacing: 15) {
           
                Text(onboardingItem.title)
                    .font(.title.bold())
                
                Text(onboardingItem.subTitle)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    Text("Terms of Service")
                        .underline(true, color: .primary)
                    Text("Privacy Policy")
                        .underline(true, color: .primary)
                }
                
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            onboardingItem.color
            
        )

        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

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
