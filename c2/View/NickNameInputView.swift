//
//  NickNameInputView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI

struct NickNameInputView: View {
    
    @State private var nickname: String = ""
    @State private var showSelectedView: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {

            VStack(spacing: 20) {
                Spacer()
                
                Text("Maze")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
                Text("Runner")
                    .font(.custom("Aclonica-Regular", size: 50))
                    .foregroundColor(Color(hex: "5ea152"))
                
                TextField("닉네임을 입력하세요!", text: $nickname)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(hex: "F1F1F1")).opacity(0.8)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                
                
                Spacer()
                
                Button(action: {
                    if Runner.isNicknameValid(nickname) {
                        showSelectedView = true
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("확인")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "5ea152")))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .navigationDestination(isPresented: $showSelectedView) {
                    
                    c2.SelectedView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("닉네임과 일치하는 러너가 없어요."), message: Text("다시 입력해주세요"), dismissButton: .default(Text("확인")))
                }
            }
        }
    }

#Preview {
    NickNameInputView()
}
