//
//  ReactiveSwiftEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import ReactiveSwift

// This effect will make the state decrease when it is already decreasing and not paused
// When the state is equal to 0, then the effect asks for an increase
func decreaseEffect(state: State) -> SignalProducer<Event, Never> {
    guard case let State.decreasing(value, pause) = state, pause == false else { return .empty }

    let scheduler = QueueScheduler(qos: .userInteractive, name: "decreaseEffect")

    if value > 0 {
        return SignalProducer<Event, Never>(value: .decrease).delay(1, on: scheduler)
    }

    return SignalProducer<Event, Never>(value: .increase).delay(1, on: scheduler)
}

// This effect will make the state increase when it is already increasing and not paused
// When the state is equal to 10, then the effect asks for a decrease
func increaseEffect(state: State) -> SignalProducer<Event, Never> {
    guard case let State.increasing(value, pause) = state, pause == false else { return .empty }

    let scheduler = QueueScheduler(qos: .userInteractive, name: "increaseEffect")

    if value < 10 {
        return SignalProducer<Event, Never>(value: .increase).delay(1, on: scheduler)
    }

    return SignalProducer<Event, Never>(value: .decrease).delay(1, on: scheduler)
}
