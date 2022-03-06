//
//  Shapes.swift
//  SetGame
//
//  Created by Sanjay Katta on 05/03/22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = CGPoint(x: rect.midX,y: rect.minY)
        path.move(to: start)
        path.addLine(to: CGPoint(x: rect.minX,y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX,y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: start)
        path.closeSubpath()
        return path;
    }
}

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = CGPoint(x: rect.maxX * 0.33, y: 0)
        path.move(to: start)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.33, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.67, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.67, y: rect.midY))
        path.addLine(to: start)
        path.closeSubpath()
        return path
    }
}
