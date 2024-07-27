//
//  PetQnAApp.swift
//  PetQnA
//
//  Created by 김동섭 on 7/10/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct PetQnAApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appState)
        }
    }
}
