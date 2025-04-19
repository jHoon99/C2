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
    @Query(sort: \RunnerAnswer.timestamp, order: .reverse) private var allAnswers: [RunnerAnswer]
    private var groupedAnswers: [UUID: [RunnerAnswer]] {
        Dictionary(grouping: allAnswers) { $0.sessionID }
    }
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(Array(groupedAnswers.keys.enumerated()), id: \.element) { index, sessionID in
                    if let answers = groupedAnswers[sessionID] {
                        NavigationLink {
                            HistoryDetailView()
                        } label: {
                            VStack {
                                Text("History \(groupedAnswers.count - index)")
                                    .font(.headline)
                                Text(answers.first?.timestamp.formatted(date: .abbreviated, time: .shortened) ?? "")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
}

#Preview {
    HistoryView()
}
