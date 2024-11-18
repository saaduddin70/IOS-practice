//
//  ContentView.swift
//  Saad
//
//  Created by Abu Loman Hossain Shuvo on 11/15/24.
//

import SwiftUI

enum Choices:String, CaseIterable {
    case Scissors = "✂️", Paper = "📄", Rock = "🗿"
}

struct ContentView: View {
    @State var computerChoice = Choices.allCases.first!
    @State var gameOutcome = ""
    
    @State var wins = 0
    @State var round = 0
    
    @State var showAlert = false
    @State var showComputerChoice = false
    var body: some View {
        GeometryReader{ geo in
            VStack {
                //Computer
                VStack{
                    if !showComputerChoice {
                        Text("👽")
                            .font(.system(size: 100))
                    }else{
                        Text(computerChoice.rawValue)
                            .font(.system(size: 100))
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                
                //Player
                VStack{
                    Text("Make your selection : ")
                        .padding()
                        .bold()
                        .font(.largeTitle)
                    HStack(spacing:0){
                        ForEach(Choices.allCases, id:\.self){ option in
                            Button(action:{
                                //Round Start
                                round += 1
                                
                                //Gemerate a computer choice
                                let index = Int.random(in: 0...Choices.allCases.count-1)
                                
                                computerChoice = Choices.allCases[index]
                                showComputerChoice = true
                                
                                // check if win
                                
                                checkWin(playerChoice: option )
                            }){
                                Text(option.rawValue)
                                    .font(.system(size: geo.size.width/CGFloat(Choices.allCases.count)))
                            }
                        }
                    }
                    HStack{
                        Spacer()
                        Text("Wins : \(wins)")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Text("Round : \(round)")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
            }
            
        }
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            Button("Play again!", role: .cancel){
                showComputerChoice = false
            }
        }
    }
    func checkWin(playerChoice:Choices){
        switch playerChoice {
        case .Scissors:
            if computerChoice == .Scissors {
                gameOutcome = "Draw"
            }
            else if computerChoice == .Paper {
                gameOutcome = "Wins"
                wins += 1
            }
            else {
                gameOutcome = "Lose"
            }
        case .Paper:
            if computerChoice == .Paper {
                gameOutcome = "Draw"
            }
            else if computerChoice == .Rock {
                gameOutcome = "Wins"
                wins += 1
            }
            else {
                gameOutcome = "Lose"
            }
        case .Rock:
            if computerChoice == .Rock {
                gameOutcome = "Draw"
            }
            else if computerChoice == .Scissors {
                gameOutcome = "Wins"
                wins += 1
            }
            else {
                gameOutcome = "Lose"
            }
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
