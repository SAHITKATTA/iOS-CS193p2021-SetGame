//
//  SetCardGameView.swift
//  SetGame
//
//  Created by Sanjay Katta on 27/02/22.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var game: SetCardGame
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Set Game")
                    .font(.largeTitle)
                Spacer()
                Button{
                    game.newGame()
                } label: {
                    HStack{
                        Image(systemName: "play.circle")
                        Text("New Game")
                    }.padding(.horizontal)
                }
            }
            ScrollView {
                VStack{
                    let columns: [GridItem] =
                    Array(repeating: .init(.adaptive(minimum: 100)), count: 5)
                    LazyVGrid(columns:columns){
                        ForEach(game.cards){card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .padding(2)
                                .onTapGesture {
                                    game.choose(card)
                                }
                        }
                    }
                }.padding(.horizontal)
            }
            HStack{
                Spacer()
                Text("Score: \(game.score) \(game.gameOver ? "Game Over" : "")")
                Spacer()
                Button{
                    game.draw()
                } label: {
                    HStack{
                        Text("Draw")
                        Image(systemName: "4.alt.square")
                    }.padding(.horizontal)
                }.disabled(game.isDraw4Disabled)
            }
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView(game: SetCardGame())
    }
}
