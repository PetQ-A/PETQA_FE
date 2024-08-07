//
//  QnAList.swift
//  PetQnA
//
//  Created by 조수민 on 8/4/24.
//

import SwiftUI

struct Question: Identifiable {
    var id: Int
    var question: String
    var date: String
}

struct QnAListView: View {
    @State private var selectedQuestion: Question? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .fill(Color("login_bg_color"))
                    .frame(height : 10)
                
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 70)
                    
                    
                        HStack {
                            Spacer()
                            Image("login_logo_txt")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                            Spacer().frame(width: 30)
                            Image("login_logo_img")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 70)
                            Spacer()
                        }
                }
                .padding(.vertical, 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .padding(.horizontal, 15)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(questions) { question in
                                Button(action: {
                                    selectedQuestion = question
                                }) {
                                    QuestionRow(question: question)
                                }
                            }
                        }
                        .padding(.top, 15)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                    }
                } // ZStack
                .padding(.top, 10)
                .padding(.bottom, 140)
                .background(Color("login_bg_color"))
                                
                
            } // VStack
            .background(Color(.white).edgesIgnoringSafeArea(.all))
            .sheet(item: $selectedQuestion) { question in
                QnADetail(selectedQuestion: question)
                    .presentationDetents([.height(650)])
                    .presentationDragIndicator(.hidden)
            }
            
            .navigationBarTitle("문답 리스트", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // 뒤로가기 액션
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // 아이콘 색상 설정
            })
            
        } // NavigationView
    }
}

struct QnADetail: View {
    var selectedQuestion: Question
    
    var body: some View {
        VStack {
            Text("문답 보기")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("  # \(selectedQuestion.id)  ")
                        .font(.system(size: 14))
                        .padding(2)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(.leading, 10)
                    Spacer()
                    Text(selectedQuestion.date)
                        .font(.system(size: 14))
                        .foregroundColor(.brown)
                        .padding(.trailing, 10)
                }
                .padding(.bottom, 20)
                
                Text(selectedQuestion.question)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 10)
                    .padding(.bottom, 20)
                
                DashedLine()
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 5)
                
                HStack {
                    Spacer()
                    Button(action: {
                        // 버튼 액션
                    }) {
                        HStack(spacing: 5) {
                            Text("답변 수정하기")
                            
                            Image(systemName: "pencil")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .padding(.leading, 20)
                    }
                }
                
                Text("답변 내용을 여기에 입력하세요.")
                    .font(.system(size: 14))
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                    
            }
            .padding()
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct QuestionRow: View {
    var question: Question
    
    var body: some View {
        VStack {
            HStack {
                Text("\(question.id)")
                    .font(.system(size: 14))
                    .padding(6)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                
                Text(question.question)
                    .font(.system(size: 14))
                    .lineLimit(1)
                
                Spacer()
                
                Text(question.date)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            DashedLine()
                .padding(.top, 10)
        }
    }
}


let questions: [Question] = [
    Question(id: 1, question: "저에게 직업이 있었다면 어떤 직업이었을까요?", date: "24.06.19"),
    Question(id: 2, question: "절 크게 혼낸 적이 있나요? 어떤 사고를 쳤나요?", date: "24.06.19"),
    Question(id: 3, question: "저와의 첫만남을 이야기해주세요!", date: "24.06.19"),
    Question(id: 4, question: "글자 수가 초과될 경우 ...처리", date: "24.06.19")
]

#Preview {
    QnAListView()
}
