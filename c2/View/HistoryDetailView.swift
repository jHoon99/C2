//
//  HistoryDetailView.swift
//  c2
//
//  Created by 조재훈 on 4/19/25.
//

import SwiftUI
import SwiftData

struct HistoryDetailView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: MazeViewModel
    
    let answers: [RunnerAnswer]
    
    init(viewModel: MazeViewModel = MazeViewModel(runner: Runner(nickname: ""), modelContext: nil), answers: [RunnerAnswer]) {
        _viewModel = State(initialValue: viewModel)
        self.answers = answers
    }
    
    var body: some View {
        
        List {
            ForEach(answers) { answers in
                HStack {
                    Text("\(answers.selectedText) \(answers.selectedEmoji)")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(Color(hex: "5ea152").opacity(0.5))
                .cornerRadius(10)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        modelContext.delete(answers)
                        try? modelContext.save()
                        viewModel.loadSessionGroups()
                    } label: {
                        Label("삭제", systemImage: "trash.fill")
                    }
                }
            }
        }
        
    }
}

#Preview {
    HistoryDetailView(answers: [RunnerAnswer]([]))
}
