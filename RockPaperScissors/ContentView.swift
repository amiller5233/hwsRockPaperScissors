//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Adam Miller on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    
    private let responseOptions = ["🪨 Rock", "📄 Paper", "✂️ Scissors"]
    private let responseLabels = ["🪨", "📄", "✂️"]
    @State private var cpuResponse = Int.random(in: 0...2)
    @State private var playerObjective = Bool.random()
    
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @State private var roundCount: Int = 0
    @State private var score: Int = 0
    
    var isGameOver: Bool {
        roundCount >= 9
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock, Paper, Scissors!")
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                VStack(spacing: 30) {
                    VStack(spacing: 10) {
                        HStack {
                            Text("The CPU chose:")
                            Spacer()
                            Text(responseOptions[cpuResponse])
                                .font(.body.weight(.bold))
                        }
                        
                        HStack {
                            Text("Your objective is to:")
                            Spacer()
                            Text(playerObjective ? "Win" : "Lose")
                                .font(.body.weight(.bold))
                        }
                    }
                    
                    Text("Which option do you pick?")
                    
                    // Buttons with text
                    /*
                    VStack(spacing: 10) {
                        ForEach(0...2, id: \.self) { number in
                            Button {
                                responseTapped(number)
                            } label: {
                                Text(responseOptions[number])
                                    .font(.body.weight(.bold))
                                    .padding(8)
                                    .frame(minWidth: 160)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.cyan)
                            
                        }
                    }
                    */
                    
                    HStack(spacing: 10) {
                        ForEach(0...2, id: \.self) { number in
                            Button {
                                responseTapped(number)
                            } label: {
                                Text(responseLabels[number])
                                    .font(.largeTitle.weight(.bold))
                                    .padding(8)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.cyan)
                        }
                    }
                }
                
                .frame(maxWidth: 300)
                .padding(25)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.body.bold())
                    .padding(.top, 30)
                
                Spacer()
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button(isGameOver ? "New Game" : "Continue") {
                continueTapped()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func responseTapped(_ number: Int) {
        if (playerObjective == didPlayerWin(cpuResponse: cpuResponse, playerResponse: number)) {
            score += 1
            alertTitle = "Correct!"
        } else {
            score -= 1
            alertTitle = "Incorrect"
        }
        
        if (isGameOver) {
            alertMessage = "Your final score is \(score)"
        } else {
            alertMessage = "Your score is \(score)"
        }
        
        showingAlert = true
    }
    
    func didPlayerWin(cpuResponse: Int, playerResponse: Int) -> Bool {
        if (playerResponse == 0 && cpuResponse == 2) {
            return true
        } else if (playerResponse == 2 && cpuResponse == 0) {
            return false
        } else {
            return playerResponse > cpuResponse
        }
    }
    
    func continueTapped() {
        cpuResponse = Int.random(in: 0...2)
        playerObjective = Bool.random()
        
        if (isGameOver) {
            roundCount = 0
            score = 0
        } else {
            roundCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
