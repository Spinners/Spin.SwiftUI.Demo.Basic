//
//  CombineEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Combine
import Dispatch

// This effect will make the state decrease when it is already decreasing and not paused
// When the state is equal to 0, then the effect asks for an increase
func decreaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.decreasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    let scheduler = DispatchQueue(label: "decreaseEffect").eraseToAnyScheduler()

    if value > 0 {
        return Just<Event>(.decrease).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
    }

    return Just<Event>(.increase).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
}

// This effect will make the state increase when it is already increasing and not paused
// When the state is equal to 10, then the effect asks for a decrease
func increaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.increasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    let scheduler = DispatchQueue(label: "increaseEffect").eraseToAnyScheduler()

    if value < 10 {
        return Just<Event>(.increase).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
    }

    return Just<Event>(.decrease).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
}
