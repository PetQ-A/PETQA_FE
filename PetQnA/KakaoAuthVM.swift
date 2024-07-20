//
//  KakaoAuthVM.swift
//  PetQnA
//
//  Created by 조수민 on 7/14/24.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class KakaoAuthVM : ObservableObject {
    
    @Published var user: User? = nil
    @Published var isLoggedIn: Bool = false
    @Published var accessTokenInfo: AccessTokenInfo? = nil
    
    func handleKakaoLogin() {
        // 카카오톡 실행 가능 여부 확인 - 설치 되어 있을 때
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오 앱을 통해 로그인
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    self.isLoggedIn = true
                    self.getUserInfo()
                }
            }
        } else { // 설치 안되어 있을 때
            // 카카오 웹뷰로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    self.isLoggedIn = true
                    self.getUserInfo()
                }
            }
        }
    }
    
    func checkTokenPresence() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
                if let error = error as? SdkError, error.isInvalidTokenError() {
                    // 로그인 필요
                    self.isLoggedIn = false
                } else {
                    // 토큰 유효
                    self.accessTokenInfo = accessTokenInfo
                    self.isLoggedIn = true
                }
            }
        } else {
            // 로그인 필요
            self.isLoggedIn = false
        }
    }
    
    func getTokenInfo() {
        UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Access Token Info: \(String(describing: accessTokenInfo))")
                self.accessTokenInfo = accessTokenInfo
            }
        }
    }
    
    func getUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User Info: \(String(describing: user))")
                self.user = user
            }
        }
    }
    
    func saveUserInfo(nickname: String, profileImageURL: String) {
        UserApi.shared.updateProfile(properties: ["nickname": nickname, "profile_image": profileImageURL]) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User profile updated successfully.")
            }
        }
    }
}
