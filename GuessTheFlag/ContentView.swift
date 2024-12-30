//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arya Mohajer on 29/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    
    
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var score = 0
    
    @State private var selectedFlag = 0
    @State private var round = 0

    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score) ")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if round >= 8 {
                Text("game is over hahahaha \n Your score is \(score)")

        
            }
            if selectedFlag != correctAnswer {
                Text("Your score is \(score) \n Wrong! That’s the flag of \(countries[selectedFlag])")
            } else {
                Text("Your score is \(score)")
                
            }}
    }
    func flagTapped(_ number: Int) {
        selectedFlag = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
          
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        if round <= 8 {
            countries.shuffle()
            round += 1
            correctAnswer = Int.random(in: 0...2);
        
            
        }
        if round > 8 {
            round = 0
            score = 0
            countries.shuffle()
            round += 1
            correctAnswer = Int.random(in: 0...2);
            
        
            
        }
       
        
    }
}

#Preview {
    ContentView()
}
