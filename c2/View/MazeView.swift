//
//  MazeView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI
import SwiftData

struct MazeView: View {
    
//    @State private var answer: String = ""
//    @Environment(\.modelContext) var modelContext
    @Query private var items: [RunnerAnswer]
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Text("ddd")
             

            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("maze Runner")
                    .font(.custom("Aclonica-Regular", size: 20))
                    .foregroundColor(Color(hex: "5ea152"))
                
            }
        }
    }
}
#Preview {
    MazeView()
}
