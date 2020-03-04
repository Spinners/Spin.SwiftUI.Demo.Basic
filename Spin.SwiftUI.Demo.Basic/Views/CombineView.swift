//
//  CombineView.swift
//  Spin.SwiftUI.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-14.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Spin_Swift
import Spin_Combine
import SwiftUI

struct CombineView: View {

    @ObservedObject
    private var uiSpin: CombineSwiftUISpin<State, Event> = {
        // the countdownSpin is the formal feedback loop definition
        // it has an initial state and 2 effects that will handle
        // the decrease and increase cycles
        // the reducer function is common to ReactiveSwift/RxSwift/Combine implementation
        let countdownSpin = Spinner
            .from(initialState: State.fixed(value: 10))
            .add(feedback: CombineFeedback(effect: decreaseEffect))
            .add(feedback: CombineFeedback(effect: increaseEffect))
            .reduce(with: CombineReducer(reducer: reducer))

        // the spin is a UI decoration of the countdownSpin
        // it is a feedback loop the has 1 special UI feedback
        // that we can use to interpret the State and emit Event
        let spin = CombineSwiftUISpin(spin: countdownSpin)
        spin.start()
        return spin
    }()

    var body: some View {
        VStack {
            HStack {
                Text("state = \(self.uiSpin.state.description)")
                    .font(.footnote)
                    .padding()
                Spacer()
            }
            Spacer()
            Text("\(self.counterValue)")
                .font(.system(size: 59))
                .foregroundColor(self.counterColor)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.uiSpin.emit(.reset(value: 10))
                }) {
                    Text("Reset")
                        .font(.system(size: 25))
                }
                .frame(width: 100, height: 30, alignment: .center)
                .padding(10)
                .background(Color.gray)
                .opacity(self.isCounterFixed ? 0.5 : 1.0)
                .foregroundColor(.white)
                .cornerRadius(20)
                .disabled(self.isCounterFixed)
                .animation(.default)

                Spacer()

                Button(action: {
                    self.uiSpin.emit(.toggle)
                }) {
                    Text("\(self.isCounterPaused ? "Start": "Stop")")
                        .font(.system(size: 25))
                }
                .frame(width: 100, height: 30, alignment: .center)
                .padding(10)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(20)

                Spacer()
            }
            .padding(20)
        }
        .padding(20)
    }
}

private extension CombineView {
    var counterValue: Int {
        switch self.uiSpin.state {
        case .fixed(let value), .decreasing(let value, _), .increasing(let value, _):
            return value
        }
    }

    var isCounterFixed: Bool {
        if case .fixed = self.uiSpin.state {
            return true
        }

        return false
    }

    var isCounterPaused: Bool {
        switch self.uiSpin.state {
        case .fixed:
            return true
        case .increasing(_, let paused), .decreasing(_, let paused):
            return paused
        }
    }

    var isCounterDecreasing: Bool {
        if case .decreasing = self.uiSpin.state {
            return true
        }

        return false
    }

    var isCounterIncreasing: Bool {
        if case .increasing = self.uiSpin.state {
            return true
        }

        return false
    }

    var counterColor: Color {
        if self.isCounterFixed {
            return .green
        }

        if self.isCounterDecreasing {
            return .red
        }

        if self.isCounterIncreasing {
            return .blue
        }

        return .accentColor
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
