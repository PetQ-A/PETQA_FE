//
//  SnackDetailView.swift
//  PetQnA
//
//  Created by 조수민 on 7/26/24.
//

import SwiftUI

struct SnackDetailView: View {
    var selectedSnack: SnackItem?
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
            VStack {
                if let snack = selectedSnack {
                    ZStack {
                        Rectangle()
                            .fill(Color("login_bg_color"))
                            .frame(height: 400)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.white))
                            .frame(width: 280, height: 230)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("login_true_btn_color"), lineWidth: 2) // 주황색 테두리 추가
                            )
                        
                        VStack(spacing: 10) {
                            Image(snack.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                                .padding(.top, 20)
                                .padding(.bottom ,20)
                            
                            Text(snack.title)
                                .font(.system(size: 16))
                            
                            Text(snack.description)
                                .font(.system(size: 12))
                                .padding(.bottom, 10)
                        }
                    }
                } else {
                    Text("선택된 간식이 없습니다.")
                        .font(.body)
                }
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                    VStack(spacing: 10) {
                        Text("1,000 point를 다 모으셨다면,")
                            .font(.headline)
                        
                        HStack {
                            Text("별이")
                                .foregroundColor(.green)
                                .font(.custom("Ownglyph meetme", size: 28))
                            +
                            Text("의 간식을 집으로 배송받아 보세요!")
                                .foregroundColor(.black)
                            
                        }
                        .font(.body)
                        .foregroundColor(.green)
                        
                        Text("🛈 마이페이지에 배송지 입력을 반드시 완료해 주세요.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: 156)
                
                
                Button(action: {
                    // 포인트로 간식 배송받기 액션
                }) {
                    Text("1000 point로 간식 배송받기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("login_true_btn_color"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .font(.custom("Ownglyph meetme", size: 18))
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("login_bg_color").edgesIgnoringSafeArea(.all))
            .navigationBarTitle("간식 받기", displayMode: .inline) // 타이틀 설정
            .navigationBarItems(leading: Button(action: {
                // 뒤로가기 액션
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // 아이콘 색상 설정
            })
    }
}

#Preview {
    SnackDetailView()
}

