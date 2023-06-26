//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Adam Miller on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var responseOptions = ["🪨 Rock", "📄 Paper", "✂️ Scissors"]
    @State private var cpuResponse = Int.random(in: 0...2)
    @State private var playerObjective = Bool.random()
    
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    
    var roundCount: Int = 0
    
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
                    
                    Text("Which option do you pick? 🤔")
                    
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
                    
                    
                }
                .frame(maxWidth: 300)
                .padding(25)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
                
                Spacer()
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue") {
                nextRound()
            }
        }
    }
    
    func responseTapped(_ number: Int) {
        if (playerObjective == didPlayerWin(cpuResponse: cpuResponse, playerResponse: number)) {
            alertTitle = "Correct!"
        } else {
            alertTitle = "Incorrect"
        }
        
        showingAlert = true
    }
    
    func didPlayerWin(cpuResponse: Int, playerResponse: Int) -> Bool {
        if (playerResponse == 0 && cpuResponse == 2) {
            return true
        } else {
            return playerResponse > cpuResponse
        }
    }
    
    func nextRound() {
        cpuResponse = Int.random(in: 0...2)
        playerObjective = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
