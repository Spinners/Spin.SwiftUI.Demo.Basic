//
//  State.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

enum State {
    case fixed(value: Int)
    case decreasing(value: Int, paused: Bool)
    case increasing(value: Int, paused: Bool)
}
