//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Sanjay Katta on 27/02/22.
//

import Foundation

//View Model


class SetCardGame: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published var model = createSetCardGame()
    
    private static func allSetCards(numberOfShapesInCard: Int) -> [Card] {
        var cards = [Card]()
        for shade in Card.Shade.allCases {
            for shape in Card.Shape.allCases {
                for setColor in Card.SetColor.allCases {
                    for noOfShapes in 1...numberOfShapesInCard {
                        cards.append(Card(id: UUID(),noOfShapes: noOfShapes, shape: shape, shade: shade, color: setColor
                        ))
                    }
                }
            }
        }
        return cards
    }
    
    private static func createSetCardGame() -> SetGame {
        SetGame { numberOfCardsOnTable, numberOfShapesInCard in
            let cards = allSetCards(numberOfShapesInCard: numberOfShapesInCard).shuffled()
            return (Array(cards[0..<numberOfCardsOnTable]),Array(cards[numberOfCardsOnTable..<cards.count]))
        }
    }
    
    func newGame() {
        self.model = SetCardGame.createSetCardGame()
    }
    
    
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    var gameOver: Bool {
        model.gameOver
    }
 
    var isDraw4Disabled: Bool {
        model.isDraw4Disabled
    }
    
    // MARK: - Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
    func draw() {
        model.draw()
    }
    
}
