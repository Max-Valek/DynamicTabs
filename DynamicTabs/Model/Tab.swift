//
//  Tab.swift
//  DynamicTabs
//
//  Created by Max Valek on 4/28/23.
//

import SwiftUI

// Tab Model
struct Tab: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    // animation properties
    var width: CGFloat = 0
    var minX: CGFloat = 0
    // just here for demo
    var color: Color
}

// Sample Tabs
var tabs_: [Tab] = [
    .init(title: "First", color: Color.black.opacity(0.2)),
    .init(title: "Second", color: Color.blue.opacity(0.2)),
    .init(title: "Third", color: Color.red.opacity(0.2)),
    .init(title: "Fourth", color: Color.green.opacity(0.2))
]
