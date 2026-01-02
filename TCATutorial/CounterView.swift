//
//  CounterView.swift
//  TCATutorial
//
//  Created by 小野寺祥吾 on 2024/12/29.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store:StoreOf<CounterFeature>
    
    var body:some View {
        VStack{
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                  store.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("トリビア詳細だよ") {
                    store.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding(5)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                
                if store.isLoading {
                    ProgressView()
                } else if let fact = store.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                }
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
