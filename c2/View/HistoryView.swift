//
//  messageView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: MazeViewModel
    
    init(viewModel: MazeViewModel = MazeViewModel(runner: Runner(nickname: ""), modelContext: nil)) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        
        List {
            ForEach(viewModel.savedAnswers) { answer in
                VStack {
                    Text("\(answer.selectedText) \(answer.selectedEmoji)")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(Color(hex: "5ea152").opacity(0.5))
                .cornerRadius(10)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        modelContext.delete(answer)
                        try? modelContext.save()
                        viewModel.loadSavedAnswers()
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            
//            .onDelete { offsets in
//                offsets.forEach { index in
//                    let answer = viewModel.savedAnswers[index]
//                    modelContext.delete(answer)
//                }
//                try? modelContext.save()
//                viewModel.loadSavedAnswers()
//            }
            
            
        }
        .onAppear {
            viewModel.loadSavedAnswers()
            
        }
        
        
    }
}

#Preview {
    HistoryView()
}
