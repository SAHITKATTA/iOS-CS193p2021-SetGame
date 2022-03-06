//
//  CardView.swift
//  SetGame
//
//  Created by Sanjay Katta on 05/03/22.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGame.Card
    var card: Card
    let lineWidth:CGFloat = 2
    let cornerRadius:CGFloat = 10
    let padding: CGFloat = 3.0
    let aspectRatio = CGSize(width: 3, height: 1)
    let opacity = 0.5
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                ForEach(1...card.noOfShapes, id: \.self) { _ in
                    cardContent()
                        .frame(height: 50 * 0.5)
                        .padding(padding)
                }
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(card.isSelected ? .clear : .gray, lineWidth: lineWidth)
            )

        }
        .frame(height: 150)
        
    }
    
    @ViewBuilder
    private func cardContent() -> some View {
        let color = card.color.getColor()
        switch card.shape {
        case .oval:
            switch card.shade {
            case .open:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(color, lineWidth: lineWidth)
            case .solid:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
            case .striped:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(color, lineWidth: lineWidth)
                    .background{
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .opacity(opacity)
                    }
                    .foregroundColor(color)
                
            }
        case .diamond:
            switch card.shade {
            case .open:
                Diamond()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
                    .padding(.horizontal, padding)
            case .solid:
                Diamond()
                    .fill(color)
            case .striped:
                Diamond()
                    .stroke(lineWidth: lineWidth)
                    .background{
                        Diamond()
                            .opacity(opacity)
                    }
                    .foregroundColor(color)
                    .padding(.horizontal, padding)
            }
        case .squiggle:
            switch card.shade {
            case .open:
                Squiggle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
                    .padding(.horizontal, padding)
            case .solid:
                Squiggle()
                    .fill(color)
            case .striped:
                Squiggle()
                    .stroke(lineWidth: lineWidth)
                    .background{
                        Squiggle()
                            .opacity(opacity)
                    }
                    .foregroundColor(color)
                    .padding(.horizontal, padding)
            }
            
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card:
                        SetGame.Card(id: UUID(), noOfShapes: 1, shape: .oval, shade: .striped, color: .green)
            )
        }
    }
}
