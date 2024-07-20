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
    @State private var petWeight: String = ""
    @State private var petGender: Gender? = nil
    @State private var isUserNameValid: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var customProfileImage: Image?
    @State private var useCustomProfileImage: Bool = false
    @State private var showToast: Bool = false
    var profileImage: String

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    enum Gender: String, CaseIterable {
        case male = "남"
        case female = "여"
    }
    
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
                
                ScrollView {
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
                                    UnderlinedTextField(placeholder: "사용자 닉네임", text: $userName)
                                        .onChange(of: userName) { newValue in
                                            isUserNameValid = false
                                        }
                                    Button(action: {
                                        // 임시 로직으로 중복 여부 확인
                                        if userName.isEmpty || userName == "중복" {
                                            showToast = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                withAnimation {
                                                    showToast = false
                                                }
                                            }
                                        } else {
                                            isUserNameValid = true
                                        }
                                    }) {
                                        Text(isUserNameValid ? "사용 가능" : "중복 확인")
                                            .font(.system(size: 10, weight: .semibold))
                                            .foregroundColor(isUserNameValid ? Color("login_btn_color") : .white)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(isUserNameValid ? Color("login_btn_color") : Color.clear, lineWidth: isUserNameValid ? 2 : 0)
                                                    .background(isUserNameValid ? Color.white : Color("login_btn_color"))
                                                    .cornerRadius(10)
                                            )
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
                                    ZStack {
                                        Text("반려동물 생일")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.black)
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 5, height: 5)
                                            .offset(x: -37, y: -10)
                                    }
                                    Text("생년월일을 8자로 표기해주세요")
                                        .font(.system(size: 8, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                                UnderlinedTextField(placeholder: "20240101", text: $petBirthdate)
                                    .keyboardType(.numberPad)
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    ZStack {
                                        Text("반려동물 성별")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.black)
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 5, height: 5)
                                            .offset(x: -37, y: -10)
                                    }
                                    Text("중성화를 받았더라도, 기존 성별을 체크해 주세요")
                                        .font(.system(size: 8, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                                HStack {
                                    ForEach(Gender.allCases, id: \.self) { gender in
                                        Button(action: {
                                            self.petGender = gender
                                        }) {
                                            Text(gender.rawValue)
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(self.petGender == gender ? .white : .gray.opacity(0.5))
                                                .frame(width: 31, height: 25)
                                                .background(self.petGender == gender ? Color("login_enterinfo_txt_color") : Color.white)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color("login_false_btn_color"), lineWidth: self.petGender == gender ? 0 : 1)
                                                )
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    ZStack {
                                        Text("반려동물 몸무게")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.black)
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 5, height: 5)
                                            .offset(x: -42, y: -10)
                                    }
                                }
                                ZStack(alignment: .trailing) {
                                    UnderlinedTextField(placeholder: "5.5", text: $petWeight)
                                        .keyboardType(.decimalPad)
                                    
                                    Text("Kg")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing, 1)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 0.3)
                }
                
                
                Spacer()
                
                Button(action: {
                    // 시작하기 버튼 액션
                }) {
                    Text("시작하기")
                        .font(.custom("Ownglyph meetme", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background((userName.isEmpty || petName.isEmpty || petBirthdate.isEmpty || petGender == nil || petWeight.isEmpty) ? Color("login_false_btn_color") : Color("login_true_btn_color"))
                        .cornerRadius(10)
                }
                .disabled(userName.isEmpty || petName.isEmpty || petBirthdate.isEmpty || petGender == nil || petWeight.isEmpty)
                .padding(.bottom, 20)
            }
            .padding()
            
            // 토스트 메시지 : 닉네임 중복
            if showToast {
                VStack {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height / 2 - 46.5 - 100)
                    Text("이미 사용중인 닉네임이에요")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 267, height: 93)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(16)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.opacity)
            }


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
                .foregroundColor(text.isEmpty ? Color.gray : Color("login_enterinfo_txt_color"))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(text.isEmpty ? Color.gray : Color("login_enterinfo_txt_color"))
                        .padding(.top, 35)
                )
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
