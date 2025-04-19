//
//  MazeView.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI
import SwiftData

struct MazeView: View {
    
    
    @State private var viewModel: MazeViewModel
    @Environment(\.modelContext) var modelContext
    
    
    @State private var showListView: Bool = false
    @State private var hourglassRotation: Double = 0
    
    init(viewModel: MazeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private var progress : Double {
        Double(viewModel.answerdCount) / Double(viewModel.selectedRandomQuestion.count)
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    ProgressView(value: progress)
                        .tint(Color(hex: "5ea152"))
                        .padding()
                }
                
                if let currentQuestion = viewModel.currentQuestion {
                    VStack {
                        Text(currentQuestion.text)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .lineSpacing(20)
                            .padding(.horizontal)
                    }
                    .padding(.top, 100)
                    
                    Spacer()
                    
                    HStack() {
                        ForEach(0..<2) { index in
                            Button {
                                viewModel.selectAnswer(index: index)
                                
                                if viewModel.isComplete {
                                    showListView = true
                                } else {
                                    viewModel.moveToNextQuestion()
                                }
                            } label: {
                                VStack(spacing: 8) {
                                    Text(currentQuestion.answers[index].text)
                                        .font(.title3)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                    Text(currentQuestion.answers[index].emoji)
                                        .font(.title2)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .background(Color(hex: "5ea152").opacity(0.5))
                                .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                HStack {
                    
                    Text("비슷한 러너를 찾고 있어요...")
                        .font(.system(size: 25, weight: .medium))
                        
                    Text("⏳")
                        .font(.title2)
                        .rotationEffect(.degrees(hourglassRotation))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                hourglassRotation = 360
                            }
                        }
                }
                .padding(.bottom, 50)
            }
            .navigationDestination(isPresented: $showListView) {
                ListView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.loadQuestion()
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
