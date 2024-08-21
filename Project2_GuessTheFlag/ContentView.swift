//
//  ContentView.swift
//  Project2_GuessTheFlag
//
//  Created by Kane on 02/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var resultMessage = ""
    @State private var score = 0
    @State private var showingReset = false
    @State private var currentQuestion = 1
    private let maxQuestion = 10

    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .red, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess The Flag")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))

                        Text("\"\(countries[correctAnswer])\"")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    .padding()

                    ForEach(0 ..< 3) { number in
                        Button {
                            self.flagTapped(at: number)
                        } label: {
                            Image(countries[number])
                        }
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(self.scoreTitle, isPresented: self.$showingScore) {
                    Button("Continue", action: reloadQuestion)
                } message: {
                    Text(self.resultMessage)
                }
                .alert("Congratulations!", isPresented: self.$showingReset) {
                    Button("Restart", action: resetAndReload)
                } message: {
                    Text("You guessed \(score)/\(maxQuestion) flags!\nDo you want to play again?")
                }

                Spacer()
                Spacer()

                Text("Your score: \(score)/\(maxQuestion)")
                    .foregroundStyle(.white)
                    .font(.title3.bold())

                Spacer()
            }
            .padding()
        }
    }

    func flagTapped(at number: Int) {
        if number == self.correctAnswer {
            scoreTitle = "Yay!"
            resultMessage = "You're correct!"
            score += 1
        } else {
            scoreTitle = "Opps!"
            resultMessage = "It's not correct!\nThat's a flag of \(countries[number])!"
        }

        if self.currentQuestion == self.maxQuestion {
            self.showingReset = true
        } else {
            self.showingScore = true
        }
        self.currentQuestion += 1
    }

    func reloadQuestion() {
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0 ... 2)
    }

    func resetAndReload() {
        self.currentQuestion = 1
        self.score = 0
        self.reloadQuestion()
    }
}

#Preview {
    ContentView()
}
