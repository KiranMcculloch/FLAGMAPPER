//
//  LongPressGestureRecognizer.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-20.
//

import Foundation
import SwiftUI

struct LongPressGesture: UIGestureRecognizerRepresentable {
    private let longPressAt: (_ position: CGPoint) -> Void
    
    init(longPressAt: @escaping (_ position: CGPoint) -> Void) {
        self.longPressAt = longPressAt
    }
    
    func makeUIGestureRecognizer(context: Context) -> UILongPressGestureRecognizer {
        UILongPressGestureRecognizer()
    }
    
    func handleUIGestureRecognizerAction(_ gesture: UILongPressGestureRecognizer, context: Context) {
        guard  gesture.state == .began else { return }
        longPressAt(gesture.location(in: gesture.view))
    }
}
