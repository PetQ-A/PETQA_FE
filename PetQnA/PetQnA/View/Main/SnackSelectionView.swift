//
//  SnackSelectionView.swift
//  PetQnA
//
//  Created by 조수민 on 7/26/24.
//

import SwiftUI

struct SnackSelectionView: View {
    @State private var selectedSnack: SnackItem? = nil
    @State private var showingConfirmationSheet = false
    @State private var navigateToDetailView = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        Spacer()
                        Spacer()
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                            
                            HStack {
                                Text("별이")
                                    .foregroundColor(.green)
                                    .font(.custom("Ownglyph meetme", size: 30))
                                +
                                Text("에게 어떤 간식을 줄까요?")
                                    .foregroundColor(.black)
                                    .font(.custom("Ownglyph meetme", size: 20))
                            }
                            .padding(.top, 40)
                            .padding(.bottom, 40)
                            .background(Color.white)
                        }
                        
                        VStack {
                            LazyVGrid(columns: [GridItem(), GridItem()]) {
                                ForEach(SnackItem.allCases, id: \.self) { snack in
                                    SnackItemView(snack: snack, isSelected: selectedSnack == snack)
                                        .onTapGesture {
                                            selectedSnack = snack
                                        }
                                }
                            }
                            .padding(10)
                            .padding(.bottom, 20)
                            
                            Button(action: {
                                if selectedSnack != nil {
                                    showingConfirmationSheet = true
                                }
                            }) {
                                Text("간식 정하기")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(selectedSnack != nil ? Color.orange : Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                    .font(.custom("Ownglyph meetme", size: 18))
                            }
                            .padding(.bottom, 10)
                            .sheet(isPresented: $showingConfirmationSheet) {
                                ConfirmationSheet(showingBottomSheet: $showingConfirmationSheet, confirmAction: {
                                    navigateToDetailView = true
                                })
                                .presentationDetents([.height(200)])
                            }
                            NavigationLink("", destination: SnackDetailView(selectedSnack: selectedSnack).navigationBarBackButtonHidden(true), isActive: $navigateToDetailView)
                            
                        }
                    }
                    .background(Color("login_bg_color"))
                }
            }
            .navigationBarTitle("간식 고르기", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // 뒤로가기 액션
                navigateToDetailView = false
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // 아이콘 색상 설정
            })
        }
    }
}

struct ConfirmationSheet: View {
    @Binding var showingBottomSheet: Bool
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("선택을 완료 하시겠습니까?")
                .font(.system(size: 18, weight: .bold))
                .padding(.top, 20)
                .padding(.leading, 20)
            
            Text("간식 선택시 받기 전까지 선택을 바꿀 수 없어요! \n신중하게 고민해 주세요.")
                .font(.system(size: 14))
                .foregroundColor(.red)
                .padding(.leading, 20)
            
            HStack {
                Button(action: {
                    showingBottomSheet = false
                }) {
                    Text("취소")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    confirmAction()
                    showingBottomSheet = false
                }) {
                    Text("확인")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SnackItemView: View {
    let snack: SnackItem
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(snack.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding()
                .padding(.top, 40)
            Text(snack.title)
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 5)
                .padding(.bottom, 5)
            Text(snack.description)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .padding(.bottom, 30)
        }
        .frame(width: 180, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
        )
    }
}

enum SnackItem: String, CaseIterable {
    case salmonTreat = "강아지용 연어 트릿"
    case chickenBreast = "강아지용 닭가슴살"
    case catSalmonTreat = "고양이용 연어 트릿"
    case catChickenCanned = "고양이용 닭가슴살 통조림"
    
    var imageName: String {
        switch self {
        case .salmonTreat: return "snack1"
        case .chickenBreast: return "snack2"
        case .catSalmonTreat: return "snack3"
        case .catChickenCanned: return "snack4"
        }
    }
    
    var title: String {
        self.rawValue
    }
    
    var description: String {
        "영양 성분 --"
    }
}


#Preview {
    SnackSelectionView()
}
