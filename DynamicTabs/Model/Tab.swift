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
}

// Sample Tabs
var tabs_: [Tab] = [
    .init(title: "First"),
    .init(title: "Second"),
    .init(title: "Third"),
    .init(title: "Fourth")
]
