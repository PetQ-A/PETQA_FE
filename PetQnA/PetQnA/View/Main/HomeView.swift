//
//  MainPageView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var showingBottomSheet = false
    
    // 임시 문답 리스트 배열
    let messages = [
        "저를 처음 만났을 때 이야기를 들려주세요!",
        "오늘 기분이 어떤가요?",
        "즐거운 하루 보내셨나요?"
    ]
    
    // 임시 ProgressView
    @State private var progress: Double = 0.2
    
    var body: some View {
        VStack {
            HStack {
                
                VStack {
                    Button(action: {
                        
                    }) {
                        ZStack {
                            // 전체 원의 배경 서클 (투명한 내부, login_true_btn_color 테두리)
                            Circle()
                                .trim(from: 0.0, to: 0.5)
                                .stroke(Color("login_true_btn_color").opacity(0.2), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                .rotationEffect(Angle(degrees: 180))
                            
                            // 진행된 부분: login_true_btn_color로 채움
                            Circle()
                                .trim(from: 0.0, to: progress / 2)
                                .stroke(Color("login_true_btn_color"), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                .rotationEffect(Angle(degrees: 180))
                            
                            // Progress Text
                            HStack(alignment: .center, spacing: 5) {
                                Text("\(Int(progress * 1000))")
                                    .font(.custom("Ownglyph meetme", size: 20))
                                    .foregroundColor(Color("login_true_btn_color"))
                                Text("/ 1000 p")
                                    .font(.custom("Ownglyph meetme", size: 10))
                                    .foregroundColor(Color.black)
                            }
                        }
                        .frame(width: 90)
                    }
                }
                .padding(.leading, 16)
                
                
                Spacer()
                
                Button(action: {
                    // 간식 고르기 창으로 이동
                }) {
                    VStack {
                        Image("main_bone")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("간식 고르기")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                
                Button(action: {
                    // 문답 리스트 창으로 이동
                }) {
                    VStack {
                        Image("main_doc")
                            .resizable()
                            .frame(width: 15, height: 20)
                            .padding(.bottom, 4)
                        Text("문답 리스트")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 6)
            .padding(.bottom, 66)
            
            
            
            // 말풍선과 고양이 이미지
            VStack {
                Button(action: {
                    // 오늘 문답하러 가기
                    showingBottomSheet = true
                }) {
                    Image("main_bubble")
                        .resizable()
                        .frame(width: 358, height: 173)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                        .overlay(
                            Text(messages.randomElement() ?? "텍스트가 없습니다.")
                                .font(.custom("Ownglyph meetme", size: 20))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom, 30)
                        )
                }
                .padding(.bottom, 45)
                .sheet(isPresented: $showingBottomSheet) {
                    AnswerBottomSheet(showingBottomSheet: $showingBottomSheet)
                        .presentationDetents([.height(650)])
                        .presentationDragIndicator(.hidden)
                }
                HStack {
                    Image("main_fullfeedbowl")
                        .resizable()
                        .frame(width: 102, height: 76)
                        .padding(.top, 150)
                    
                    Image("main_cat")
                        .resizable()
                        .frame(width: 220, height: 227)
                }
                Text("별이")
                    .font(.custom("Ownglyph meetme", size: 24))
                    .padding(.top, 20)
                    .padding(.leading, 100)
                
            }
            Spacer()
        }
        .background(Color("login_bg_color"))
    }
}

#Preview {
    HomeView()
}
