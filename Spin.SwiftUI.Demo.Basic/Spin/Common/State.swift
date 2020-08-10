//
//  State.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

enum State: Equatable {
    case fixed(value: Int)
    case decreasing(value: Int, paused: Bool)
    case increasing(value: Int, paused: Bool)
}

extension State: CustomStringConvertible {
    var description: String {
        switch self {
        case .fixed(let value):
            return ".fixed(value: \(value))"
        case .decreasing(let value, let paused):
            return ".decreasing(value: \(value), paused: \(paused))"
        case .increasing(let value, let paused):
            return ".increasing(value: \(value), paused: \(paused))"
        }
    }
}
