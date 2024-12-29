//
//  TCATutorialApp.swift
//  TCATutorial
//
//  Created by 小野寺祥吾 on 2024/12/29.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCATutorialApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCATutorialApp.store)
        }
    }
}
