//
//  ListView.swift
//  c2
//
//  Created by 조재훈 on 4/17/25.
// 씨이이이ㅣ이이이이이이이ㅣ발.       ㅇㅇㅇㅇㅇ

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var viewModel: MazeViewModel
    
    init(viewModel: MazeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        
            List {
                ForEach(viewModel.currentSessionAnswer, id: \.id) { answer in
                    if let question = Question.allQuestions.first(where: { $0.id == answer.quewstionID }) {
                        HStack {
                            Text("\(question.answers[answer.selectedIndex].text) \(question.answers[answer.selectedIndex].emoji)")
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color(hex: "5ea152").opacity(0.5))
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
            }
                NavigationLink(destination: MatchingView(viewModel: viewModel)) {
                Text("너 누구야?")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(.vertical, 15)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "5ea152")))
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            .padding(.bottom, 20)
        }
        
//        .onAppear {
//            viewModel.loadSavedAnswers()
//            answers = viewModel.savedAnswers
        }
    }


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RunnerAnswer.self, configurations: config)
        
        // 테스트 데이터 생성
        let context = container.mainContext
        let sessionID = UUID()
        let timeStamp = Date()
        
        let testAnswers = [
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[0].id, selectedIndex: 0, sessionID: sessionID, timestamp: timeStamp, questionText: ""),
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[1].id, selectedIndex: 1, sessionID: sessionID, timestamp: timeStamp, questionText: ""),
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[2].id, selectedIndex: 0, sessionID: sessionID, timestamp: timeStamp, questionText: "")
        ]
        
        testAnswers.forEach { context.insert($0) }
        
        return ListView(viewModel: MazeViewModel(
            runner: Runner(nickname: "TestRunner"),
            modelContext: context
        ))
        .modelContainer(container)
    }
}
