//
//  CombineEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Combine
import Dispatch
import Spin_Combine

func decreaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.decreasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    let scheduler = DispatchQueue(label: "decreaseEffect").eraseToAnyScheduler()

    if value > 0 {
        return Just<Event>(.decrease).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
    }

    return Just<Event>(.increase).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
}

func increaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.increasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    let scheduler = DispatchQueue(label: "increaseEffect").eraseToAnyScheduler()

    if value < 10 {
        return Just<Event>(.increase).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
    }

    return Just<Event>(.decrease).delay(for: 1, scheduler: scheduler).eraseToAnyPublisher()
}
