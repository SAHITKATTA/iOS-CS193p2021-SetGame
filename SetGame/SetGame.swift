//
//  SetGame.swift
//  SetGame
//
//  Created by Sanjay Katta on 27/02/22.
//

import SwiftUI

// V

struct SetGame {
    
    private static let numberOfShapesInCard = 3
    private static let numberOfCardsOnTable = 12
    private static let numberOfCardsToDraw = 3
    private static let maxCardsToSelect = 3
    
    private var pickedCards: [Card]
    private var remainingCards: [Card]
    var score: Int
    var gameOver = false
    var isDraw4Disabled: Bool {
        remainingCards.isEmpty
    }
    
    var cards: [Card] {
        pickedCards.filter { !$0.isMatched }
    }
    
    private var selectedCardsCount: Int {
        pickedCards.filter { $0.isSelected && !$0.isMatched }.count
    }
    
    init(_ cards: (_ numberOfCardsOnTable: Int, _ numberOfShapesInCard:Int ) -> ([Card],[Card])) {
        let cards = cards(SetGame.numberOfCardsOnTable, SetGame.numberOfShapesInCard)
        self.pickedCards = cards.0
        self.remainingCards = cards.1
        self.score = 0
    }
    
    mutating func choose(_ card: Card){
        if selectedCardsCount < SetGame.maxCardsToSelect {
            // User can select and deselect
            let index = pickedCards.firstIndex(where: {$0.id == card.id} )!
            self.pickedCards[index].isSelected = !pickedCards[index].isSelected
            let selectedCards = pickedCards.filter { $0.isSelected && !$0.isMatched }
            if selectedCardsCount == SetGame.maxCardsToSelect { // when third is selected
                if matched(selectedCards){
                    score += 1
                    for i in selectedCards.map({$0.id}) {
                        let index = pickedCards.firstIndex(where: {$0.id == i})!
                        self.pickedCards[index].isMatched  = true
                    }
                    draw()
                }else {
                    score -= 1
                    if remainingCards.count == 0 {
                        gameOver = true
                    }
                    else {
                        for i in selectedCards.map({$0.id}) {
                            let index = pickedCards.firstIndex(where: {$0.id == i})!
                            self.pickedCards[index].isSelected  = false
                        }
                        self.pickedCards = self.pickedCards.shuffled()
                    }
                }
            }
        } else {
            
        }
        
    }
    mutating func matched(_ cards: [Card]) -> Bool {
        let firstCard = cards[0]
        let secondCard = cards[1]
        let thirdCard = cards[2]
            if ((firstCard.shade == secondCard.shade) && (firstCard.shade == thirdCard.shade) && (secondCard.shade == thirdCard.shade))  ||
                ((firstCard.color == secondCard.color) && (firstCard.color == thirdCard.color) && (secondCard.color == thirdCard.color)) ||
                ((firstCard.shape == secondCard.shape) && (firstCard.shape == thirdCard.shape) && (secondCard.shape == thirdCard.shape)) ||
                ((firstCard.noOfShapes == secondCard.noOfShapes) && (firstCard.noOfShapes == thirdCard.noOfShapes) && (secondCard.noOfShapes == thirdCard.noOfShapes)) {
                return true
            }
        return false
    }
    
    mutating func draw(){
        let drawCount = remainingCards.count < SetGame.numberOfCardsToDraw ? remainingCards.count : SetGame.numberOfCardsToDraw;
        for _ in 0..<drawCount {
            pickedCards.append(remainingCards.popLast()!)
        }
    }
    
    struct Card: Identifiable {
        var id: UUID
        var noOfShapes: Int
        var shape: Shape
        var shade: Shade
        var color: SetColor
        var isSelected = false
        var isMatched = false
        
        enum Shape: CaseIterable {
            case diamond, squiggle, oval
        }
        enum Shade: CaseIterable {
            case solid, striped, open
        }
        enum SetColor: CaseIterable {
            case red, green, purple
            func getColor () -> Color {
                switch self {
                case .red:
                    return .red
                case .green:
                    return .green
                case .purple:
                    return .purple
                }
            }
        }
    }
    
}


/*

 -- 1. Users must be able to select up to 3 cards by touching on them in an attempt to make a Set (i.e. 3 cards which match, per the rules of Set). It must be clearly visible to the user which cards have been selected so far.

 --2. After 3 cards have been selected, you must indicate whether those 3 cards are a match or mismatch. You can show this any way you want (colors, borders, backgrounds, whatever). Anytime there are 3 cards currently selected, it must be clear to the user whether they are a match or not (and the cards involved in a non-matching trio must look different than the cards look when there are only 1 or 2 cards in the selection).

 --3. Support “deselection” by touching already-selected cards (but only if there are 1 or 2 cards (not 3) currently selected).

 4. When any card is touched on and there are already 3 matching Set cards selected, then …
    a. as per the rules of Set, replace those 3 matching Set cards with new ones from the deck
    b. if the deck is empty then the space vacated by the matched cards (which cannot be replaced since there are no more cards) should be made available to the remaining cards (i.e. which may well then get bigger)
    c. if the touched card was not part of the matching Set, then select that card
    d. if the touched card was part of a matching Set, then select no card

 --5. When any card is touched and there are already 3 non-matching Set cards selected, deselect those 3 non-matching cards and select the touched-on card (whether or not it was part of the non-matching trio of cards).

 --6.You will need to have a “Deal 3 More Cards” button (per the rules of Set).
    a. when it is touched, replace the selected cards if the selected cards make a Set
    b. or, if the selected cards do not make a Set (or if there are fewer than 3 cards selected, including none), add 3 new cards to join the ones already on screen (and do not affect the selection)
    c. disable this button if the deck is empty

 --7.You also must have a “New Game” button that starts a new game (i.e. back to 12 randomly chosen cards).

 */
