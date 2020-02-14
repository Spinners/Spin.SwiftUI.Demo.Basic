//
//  RxSwiftView.swift
//  Spin.SwiftUI.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-14.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Spin_Swift
import Spin_RxSwift
import SwiftUI

struct RxSwiftView: View {

    @ObservedObject
    private var uiSpin: RxUISpin<State, Event> = {
        let countdownSpin = Spinner
            .from(initialState: State.fixed(value: 10))
            .add(feedback: RxFeedback(effect: decreaseEffect))
            .add(feedback: RxFeedback(effect: increaseEffect))
            .reduce(with: RxReducer(reducer: reducer))

        let spin = RxUISpin(spin: countdownSpin)
        spin.spin()
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
                }.disabled(self.isCounterFixed)
                Spacer()
                Button(action: {
                    self.uiSpin.emit(.toggle)
                }) {
                    Text("\(self.isCounterPaused ? "Start": "Pause")")
                        .font(.system(size: 25))
                }
                Spacer()
            }
        }
        .padding(20)
    }
}

private extension RxSwiftView {
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

struct RxSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        RxSwiftView()
    }
}
