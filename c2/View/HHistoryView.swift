//
//  HHistoryView.swift
//  c2
//
//  Created by 조재훈 on 4/22/25.
//

import SwiftUI

struct HHistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: MazeViewModel
    
    init(viewModel: MazeViewModel = MazeViewModel(runner: Runner(nickname: ""), modelContext: nil)) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(Array(viewModel.sessionGroupes.enumerated()), id: \.element.id) { index, session in
                    HStack {
                        Text("History \(index + 1)")
                    }
                    NavigationLink(destination: HistoryDetailView(answers: session.answers)) {
                        LazyVGrid(columns: Array(repeating: .init(), count: 7)) {
                            ForEach(session.answers.prefix(7)) { answer in
                                Text(answer.selectedEmoji)
                                    
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            session.answers.forEach {
                                modelContext.delete($0)
                            }
                            try? modelContext.save()
                            viewModel.loadSessionGroups()
                        } label: {
                            Label("전체 삭제", systemImage: "trash.fill")
                        }
                    }
                }

            }
            
        }
        .onAppear {
            viewModel.loadSessionGroups()
        }
        
    }
}

#Preview {
    HHistoryView()
}
