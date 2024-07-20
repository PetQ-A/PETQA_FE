//
//  LoginEnterInfoView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/10/24.
//

import SwiftUI
import PhotosUI

struct LoginEnterInfoView: View {
    @State private var userName: String = ""
    @State private var petName: String = ""
    @State private var petBirthdate: String = ""
    @State private var isUserNameValid: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var customProfileImage: Image?
    @State private var useCustomProfileImage: Bool = false
    var profileImage: String

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            Color("login_bg_color")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .frame(width: 30, height: 40)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                Spacer().frame(height: 30)
                
                HStack {
                    Text("아래 정보를 입력하면\n시작할 수 있어요!")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 20)
                    Spacer()
                }
                
                Spacer().frame(height: 40)
                
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 100, height: 100)
                            .overlay(Circle().stroke(Color.gray.opacity(0.4), lineWidth: 1))

                        if useCustomProfileImage, let customProfileImage = customProfileImage {
                            customProfileImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        }
                    }
                    
                    Button(action: {
                        self.showActionSheet.toggle()
                    }) {
                        Text("프로필 사진 변경")
                            .font(.system(size: 8, weight: .semibold))
                            .foregroundColor(Color("login_btn_color"))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("login_btn_color"), lineWidth: 2)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            )
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("프로필 사진 설정"),
                            buttons: [
                                .default(Text("앨범에서 사진 선택")) {
                                    self.showImagePicker.toggle()
                                },
                                .default(Text("기본 프로필 이미지 적용")) {
                                    self.useCustomProfileImage = false
                                },
                                .cancel(Text("취소"))
                            ]
                        )
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }

                    Spacer().frame(height: 20)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            HStack {
                                ZStack {
                                    Text("사용자 닉네임")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                    
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 5, height: 5)
                                        .offset(x: -37, y: -10)
                                }
                                Spacer()
                            }
                            HStack {
                                UnderlinedTextField(placeholder: "최대 n글자", text: $userName)
                                Button(action: {
                                    // 중복 확인 - 후에 서버와 연동 시 구체적인 로직 구현 예정
                                    // isUserNameValid = checkUserName(userName)
                                    isUserNameValid = userName.count > 0 // 임시 로직
                                }) {
                                    Text(isUserNameValid ? "사용 가능" : "중복 확인")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(isUserNameValid ? Color("login_btn_color") : Color("login_btn_color"))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                Text("반려동물 이름")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 5, height: 5)
                                    .offset(x: -37, y: -10)
                            }
                            UnderlinedTextField(placeholder: "최대 n글자", text: $petName)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text("반려동물 생일")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                Text("생년월일을 8자로 표기해주세요")
                                    .font(.system(size: 8, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            UnderlinedTextField(placeholder: "20240101", text: $petBirthdate)
                                .keyboardType(.numberPad)
                        }
                    }
                }
                .padding()
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 0.3)
                
                Spacer()
                
                Button(action: {
                    // 시작하기 버튼 액션
                }) {
                    Text("시작하기")
                        .font(.custom("Ownglyph meetme", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background((userName.isEmpty || petName.isEmpty || petBirthdate.isEmpty) ? Color.gray : Color.red)
                        .cornerRadius(10)
                }
                .disabled(userName.isEmpty || petName.isEmpty || petBirthdate.isEmpty)
                .padding(.bottom, 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        customProfileImage = Image(uiImage: inputImage)
        useCustomProfileImage = true
    }
}

struct UnderlinedTextField: View {
    var placeholder: String
    @Binding var text: String
    var width: CGFloat = UIScreen.main.bounds.width - 150
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .font(.subheadline)
                .frame(width: width)
                .overlay(Rectangle().frame(height: 1).padding(.top, 35))
                .foregroundColor(.gray)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    LoginEnterInfoView(profileImage: "profile_placeholder")
}

// 오리지널 UnderlinedTextField
//struct UnderlinedTextField: View {
//    var placeholder: String
//    @Binding var text: String
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            TextField(placeholder, text: $text)
//                .overlay(Rectangle().frame(height: 1).padding(.top, 35))
//                .foregroundColor(.gray)
//        }
//        .padding(.bottom, 10)
//    }
//}
