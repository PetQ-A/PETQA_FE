//
//  LoginSelectPetView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/10/24.
//

import SwiftUI

struct LoginSelectPetView: View {
    @State private var selectedPet: PetType? = nil
    
    // 다음 LoginEnterInfoView에 사용자가 선택한 아이로 기본 프사 넘길 것들
    enum PetType {
        case dog, cat
        
        var imageName: String {
            switch self {
            case .dog:
                return "login_enterinfo_dog"
            case .cat:
                return "login_enterinfo_cat"
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("login_bg_color")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Image(systemName: "chevron.left")
                            .frame(width: 30, height: 40)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer().frame(height: 40)
                    HStack {
                        Text("000님의 반려동물은\n어떤 친구인가요?")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.top, 40)
                        Spacer()
                    }

                    Spacer().frame(height: 100)
                    HStack(spacing: 20) {
                        Button(action: {
                            selectedPet = .dog
                        }) {
                            VStack {
                                Image("login_dog")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedPet == .dog ? Color.red : Color.clear, lineWidth: 2)
                            )
                        }
                        
                        Button(action: {
                            selectedPet = .cat
                        }) {
                            VStack {
                                Image("login_cat")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedPet == .cat ? Color.red : Color.clear, lineWidth: 2)
                            )
                        }
                    }
                    
                    Spacer().frame(height: 40)
                    Spacer()
                    NavigationLink(
                        value: selectedPet
                    ) {
                        Text("선택 완료")
                            .font(.custom("Ownglyph meetme", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedPet != nil ? Color("login_true_btn_color") : Color("login_false_btn_color"))
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                    }
                    .disabled(selectedPet == nil)
                }
                .padding()
            }
            .navigationDestination(for: PetType.self) { petType in
                LoginEnterInfoView(profileImage: petType.imageName)
            }
        }
    }
}

#Preview {
    LoginSelectPetView()
}
