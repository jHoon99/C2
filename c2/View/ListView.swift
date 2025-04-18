//
//  ListView.swift
//  c2
//
//  Created by 조재훈 on 4/17/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: MazeViewModel
    @State private var answers: [RunnerAnswer] = []
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(answers) { answer in
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
            }
            
        }
        .onAppear {
            viewModel.loadSavedAnswers()
            answers = viewModel.savedAnswers
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RunnerAnswer.self, configurations: config)
        
        // 테스트 데이터 생성
        let context = container.mainContext
        let testAnswers = [
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[0].id, selectedIndex: 0),
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[1].id, selectedIndex: 1),
            RunnerAnswer(id: UUID(), quewstionID: Question.allQuestions[2].id, selectedIndex: 0)
        ]
        
        testAnswers.forEach { context.insert($0) }
        
        return ListView(viewModel: MazeViewModel(
            runner: Runner(nickname: "TestRunner"),
            modelContext: context
        ))
        .modelContainer(container)
    }
}
