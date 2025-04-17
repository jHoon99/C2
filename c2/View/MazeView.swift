//
//  MazeView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI
import SwiftData

struct MazeView: View {
    
    @StateObject var viewModelPreview = MazeViewModel(runner: Runner(nickname: ""), modelContext: nil)
    @StateObject var viewModel: MazeViewModel
    @Environment(\.modelContext) var modelContext
    @Query var items: [RunnerAnswer]
    
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
    @Previewable @Environment(\.modelContext) var modelContext
    let viewModel = MazeViewModel(runner: Runner(nickname: ""), modelContext: modelContext)
    MazeView(viewModel: viewModel)
}



