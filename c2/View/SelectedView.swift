//
//  SelectedView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI

struct SelectedView: View {
    
    @State private var showMazeView: Bool = false
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 10) {
                
                Spacer()
                
                Text("Maze")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
                Text("Runner")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
                
                
                HStack {
                    
                    NavigationLink(
                        destination: MazeView(viewModel: MazeViewModel(runner: Runner(nickname: ""), modelContext: modelContext)))
                    {
                        //mazeView 이동
                        Text("러너 미로 풀기")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .background(Color(hex: "5ea152"))
                    }
                    .cornerRadius(20)
                    
                    
                    Rectangle()
                        .fill(.white)
                        .frame(width: 1)
                    
                    NavigationLink(destination: HistoryView()) {
                        Text("나에게 온 메세지")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .background(Color(hex: "5ea152"))
                    }
                    .cornerRadius(20)
                    
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 150)
                
            }
            .padding(.top, 200)
            
        }
    }
}
#Preview {
    SelectedView()
}
