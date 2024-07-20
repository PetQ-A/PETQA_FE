//
//  ContentView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/10/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    
    @StateObject var kakaoAuthVM : KakaoAuthVM = KakaoAuthVM()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 배경 이미지 1
                Image("logo_foot1")
                    .position(x: geometry.size.width * 0.43, y: geometry.size.height * 0.25)

                // 배경 이미지 2
                Image("logo_foot2")
                    .position(x: geometry.size.width * 0.68, y: geometry.size.height * 0.68)

                // 배경 이미지 3
                Image("logo_foot3")
                    .position(x: geometry.size.width * 0.22, y: geometry.size.height * 0.94)

                // 본격적인 View 작업
                VStack {
                    Spacer()
                    Image("login_logo_img")
                        .padding(.top, 55)
                    
                    Image("login_logo_txt")
                        .padding(.bottom, 10)
                    
                    // 폰트 가져오기 1
                    Text("반려동물과의 특별한 기록, 지금 시작해요!")
                        .font(.custom("Ownglyph meetme", size: 17))
                        .padding(.bottom, -10)
                    
                    Spacer()
                    
                    VStack {
                        
                        HStack {
                            Text("이전에 ")
                                .font(.subheadline)
                                .foregroundColor(.brown)
                            + Text("카카오")
                                .font(.headline)
                                .foregroundColor(.black)
                            + Text("로 로그인한 기록이 있어요")
                                .font(.subheadline)
                                .foregroundColor(.brown)
                        }
                        .padding(.bottom, 10)
                        
                        Button(action: {
                            // 카카오로 시작하기 버튼 액션
                            if (UserApi.isKakaoTalkLoginAvailable()) {
                                //카카오톡이 설치되어있다면 카카오톡을 통한 로그인 진행
                                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                    print(oauthToken?.accessToken)
                                    print(error)
                                }
                            }else{
                                //카카오톡이 설치되어있지 않다면 사파리를 통한 로그인 진행
                                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                    print(oauthToken?.accessToken)
                                    print(error)
                                }
                            }
                        }) {
                            Image("kakao_login_btn")
                        }
                        
                        Button(action: {
                            // Apple로 시작하기 버튼 액션
                        }) {
                            Image("apple_login_btn")
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
