//
//  RxSwiftEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import RxSwift

func decreaseEffect(state: State) -> Observable<Event> {
    guard case let State.decreasing(value, _) = state else { return .empty() }

    let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "decreaseEffect")

    if value > 0 {
        return Observable<Event>.just(.decrease).delay(.seconds(1), scheduler: scheduler)
    }

    return Observable<Event>.just(.increase).delay(.seconds(1), scheduler: scheduler)
}

func increaseEffect(state: State) -> Observable<Event> {
    guard case let State.increasing(value, _) = state else { return .empty() }

    let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "increaseEffect")

    if value < 10 {
        return Observable<Event>.just(.increase).delay(.seconds(1), scheduler: scheduler)
    }

    return Observable<Event>.just(.decrease).delay(.seconds(1), scheduler: scheduler)
}
