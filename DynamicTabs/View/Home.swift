//
//  Home.swift
//  DynamicTabs
//
//  Created by Max Valek on 4/28/23.
//

import SwiftUI

struct Home: View {
    // keep track of current tab
    @State private var currentTab: Tab = tabs_[0]
    // for updating tab width and position
    @State private var tabs: [Tab] = tabs_
    // first tab is 0
    @State private var contentOffset: CGFloat = 0
    // underline size and position
    @State private var indicatorWidth: CGFloat = 0
    @State private var indicatorPosition: CGFloat = 0
    
    var body: some View {
        
        TabView(selection: $currentTab) {
            
            ForEach(tabs) { tab in
                
                GeometryReader { geo in
                    
                    Rectangle()
                        .fill(tab.color)
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                .clipped()
                .ignoresSafeArea()
                // in ScrollOffset file
                .offsetX { rect in
                    if currentTab.title == tab.title {
                        contentOffset = rect.minX - (rect.width * CGFloat(index(of: tab)))
                    }
                    
                    updateTabFrame(rect.width)
                }
                .tag(tab)
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            TabsView()
        }
//        .overlay {
//            Text("\(contentOffset)")
//        }
    }
    
    // calculate tab width and position
    func updateTabFrame(_ tabViewWidth: CGFloat) {
        
        // array of float values for each tab (index * tab width)
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * tabViewWidth
        }
        
        // array containing width of each tab
        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }
        
        // array containing min x of each tab
        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }
        
        let widthInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        
        let positionInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
        
        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
    }
    
    // Get the index of the tab
    func index(of tab: Tab) -> Int {
        return tabs.firstIndex(of: tab) ?? 0
    }
    
    // Top Tabs
    @ViewBuilder
    func TabsView() -> some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $tab in
                Text(tab.title)
                    .fontWeight(.semibold)
                    // save tab's min x and width for calculations
                    .offsetX { rect in
                        tab.minX = rect.minX
                        tab.width = rect.width
                    }
                
                if tab != tabs.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding([.top, .horizontal], 15)
        .overlay(alignment: .bottomLeading) {
            Rectangle()
                .frame(width: indicatorWidth, height: 4)
                .offset(x: indicatorPosition, y: 10)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
