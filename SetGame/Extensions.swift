//
//  Extensions.swift
//  SetGame
//
//  Created by Sanjay Katta on 27/02/22.
//

import SwiftUI

extension View {
  @ViewBuilder
  func modify<Transform: View>(
    when condition: Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
