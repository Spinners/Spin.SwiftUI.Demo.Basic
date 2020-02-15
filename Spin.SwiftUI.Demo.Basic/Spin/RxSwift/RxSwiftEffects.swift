//
//  RxSwiftEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import RxSwift

// This effect will make the state decrease when it is already decreasing and not paused
// When the state is equal to 0, then the effect asks for an increase
func decreaseEffect(state: State) -> Observable<Event> {
    guard case let State.decreasing(value, _) = state else { return .empty() }

    let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "decreaseEffect")

    if value > 0 {
        return Observable<Event>.just(.decrease).delay(.seconds(1), scheduler: scheduler)
    }

    return Observable<Event>.just(.increase).delay(.seconds(1), scheduler: scheduler)
}

// This effect will make the state increase when it is already increasing and not paused
// When the state is equal to 10, then the effect asks for a decrease
func increaseEffect(state: State) -> Observable<Event> {
    guard case let State.increasing(value, _) = state else { return .empty() }

    let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "increaseEffect")

    if value < 10 {
        return Observable<Event>.just(.increase).delay(.seconds(1), scheduler: scheduler)
    }

    return Observable<Event>.just(.decrease).delay(.seconds(1), scheduler: scheduler)
}
