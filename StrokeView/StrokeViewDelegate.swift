//
//  StrokeViewDelegate.swift
//  StrokeView
//
//  Created by Kazuya Ueoka on 2018/09/23.
//  Copyright © 2018 Kazuya Ueoka. All rights reserved.
//

import Foundation

public protocol StrokeViewDelegate: class {
    
    /// Notification to delegate after one stroke
    ///
    /// - Parameter strokeView: StrokeView
    func strokeViewDidStroke(_ strokeView: StrokeView)
}
