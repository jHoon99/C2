//
//  ContentView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showNicknameView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Maze")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
                Text("Runner")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
            }
            .padding(.top, 250)
            
            Spacer()
            
            NavigationLink(destination: {
                NickNameInputView()
            }, label: {
                Text("시작하기")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .padding(.vertical, 15)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "5ea152")))
            })
            
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            }
        .tint(Color(hex: "5ea152"))
        }
    }


#Preview {
    ContentView()
}
