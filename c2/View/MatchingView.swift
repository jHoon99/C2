//
//  MatchingView.swift
//  c2
//
//  Created by 조재훈 on 4/20/25.
//

import SwiftUI
import SwiftData


struct MatchingView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: MazeViewModel
    @State var BackSelectedView: Bool = false
    @State private var nickName: String = ""

    var body: some View {
        VStack(spacing: 32) {
            // 결과 카드
            VStack(spacing: 16) {
                Text("당신과 가장 잘 맞는 러너는")
                    .font(.headline)
                Text("\(nickName) 입니다!")
                    .font(.largeTitle)
                    .bold()
                Text("이런게 잘 맞아요!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // 맞춘 답변들
                ForEach(viewModel.currentSessionAnswer) { answer in
                    if let question = Question.allQuestions.first(where: { $0.id == answer.quewstionID }) {

                        Text(" \(question.answers[answer.selectedIndex].text) \(question.answers[answer.selectedIndex].emoji)")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "5ea152").opacity(0.5))
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)

            // 홈 화면 버튼
            
            NavigationLink(destination: SelectedView()) {
                Text("홈 화면")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(hex: "5ea152"))
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
//            Button {
//                BackSelectedView = true
//            } label: {
//                Text("홈 화면")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 50)
//                    .background(Color(hex: "5ea152"))
//                    .cornerRadius(25)
//                    .padding(.horizontal)
//            }
//            .navigationDestination(isPresented: $BackSelectedView) {
//                HHistoryView()
//            }
            Spacer()
        }
        .padding(.top, 50)
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("maze Runner")
                    .font(.custom("Aclonica-Regular", size: 20))
                    .foregroundColor(Color(hex: "5ea152"))
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            //MARK: 등록된 러너들불러옴
            viewModel.loadPreloadedRunners()
            //MARK: 가장 비슷한 사람 찾기
            nickName = viewModel.findBestMatch()
        }
    }
}

// Preview
struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RunnerAnswer.self, configurations: config)
        let context = container.mainContext
        
        // 테스트 데이터 생성
        let sessionID = UUID()
        let testAnswers = [
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[0].id, selectedIndex: 0, sessionID: sessionID, timestamp: Date(), questionText: "", selectedText: "", selectedEmoji: ""),
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[1].id, selectedIndex: 1, sessionID: sessionID, timestamp: Date(), questionText: "", selectedText: "", selectedEmoji: "")
        ]
        
        // 답변 저장
        testAnswers.forEach { context.insert($0) }
        
        // ViewModel 생성 및 초기화
        let viewModel = MazeViewModel(
            runner: Runner(nickname: "TestRunner"),
            modelContext: context
        )
        
        // 답변 추가를 위한 selectAnswer 호출
        for answer in testAnswers {
            viewModel.selectAnswer(index: answer.selectedIndex)
        }
        
        return MatchingView(viewModel: viewModel)
            .modelContainer(container)
    }
}
