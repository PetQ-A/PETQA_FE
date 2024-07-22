//
//  AnswerBottomSheet.swift
//  PetQnA
//
//  Created by 조수민 on 7/21/24.
//

import SwiftUI

struct AnswerBottomSheet: View {
    @Binding var showingBottomSheet: Bool
    @State var answerText: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("답변하기")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Spacer()
                    Button(action: {
                        showingBottomSheet = false
                    }) {
                        Image(systemName: "xmark")
                            .padding(.trailing, 10)
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.borderless)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("  # 1  ")
                        .font(.system(size: 14))
                        .padding(2)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(.leading, 10)
                    Spacer()
                    Text(currentDateString())
                        .font(.system(size: 14))
                        .foregroundColor(.brown)
                        .padding(.trailing, 10)
                }
                    .padding(.bottom, 20)
                Text("저를 처음 만났을 때 이야기를 들려주세요!")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 10)
                    .padding(.bottom, 20)
                DashedLine()
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                TextField("답변을 작성해 주세요.", text: $answerText)
                    .padding()
                    .cornerRadius(8)
                    .font(.system(size: 14))
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                //Action for bottom button
            }) {
                Text("작성 완료")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(answerText.isEmpty ? Color.gray.opacity(0.5) : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 10)
            .disabled(answerText.isEmpty)
            
        }
    }
    func currentDateString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd"
            return formatter.string(from: Date())
        }
}


