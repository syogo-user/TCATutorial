
//  TCATutorialCounterTests.swift
//  TCATutorial
//
//  Created by 小野寺祥吾 on 2025/02/06.
//

import ComposableArchitecture
//import Testing 一時的にコメントアウト


@testable import TCATutorial


@MainActor
struct TCATutorialCounterTests {
  @Test
  func basics() async {
      let store = TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
      }
      await store.send(.incrementButtonTapped)
      await store.send(.decrementButtonTapped)
  }
}
