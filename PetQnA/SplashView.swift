//
//  SplashView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/10/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isSplachActive = false
    @State private var opacity = 1.0
    
    var body: some View {
        if isSplachActive {
            LoginView()
        } else {
            ZStack {
                Color("splash_bg_color")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Image("logo_img")
                    Image("logo_txt")
                    
                    Spacer()
                }
            }
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.9)) {
                    opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    withAnimation {
                        isSplachActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}

