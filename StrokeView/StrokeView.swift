//
//  StrokeView.swift
//  StrokeView
//
//  Created by Kazuya Ueoka on 2018/09/23.
//  Copyright © 2018 Kazuya Ueoka. All rights reserved.
//

import UIKit

open class StrokeView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private lazy var setUp: () -> () = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle(panGesture:)))
        addGestureRecognizer(panGesture)
        return {}
    }()
    
    /// point of last touched
    var lastPoint: CGPoint?
    
    /// is positive
    var isPositive: Bool?
    
    /// total moved length
    var totalMoved: CGFloat = 0
    
    /// number of judgement as a stroke
    public var threshold: CGFloat = 180.0
    
    /// number of gestures(one direction)
    var numberOfGestures: Int = 0
    
    @objc func handle(panGesture: UIPanGestureRecognizer) {
        let currentPoint = panGesture.location(in: panGesture.view)
        
        switch panGesture.state {
        case .began:
            lastPoint = currentPoint
        case .changed:
            if let lastPoint = lastPoint {
                handle(last: lastPoint, current: currentPoint)
            }
            lastPoint = currentPoint
        default:
            lastPoint = nil
            isPositive = nil
            totalMoved = 0
            numberOfGestures = 0
        }
    }
    
    func handle(last lastPoint: CGPoint, current currentPoint: CGPoint) {
        let diff: CGFloat
        switch direction {
        case .horizontal:
            diff = currentPoint.x - lastPoint.x
        case .vertical:
            diff = currentPoint.y - lastPoint.y
        }
        
        let currentIsPositive = 0 < diff
        if let isPositive = isPositive {
            if isPositive == currentIsPositive {
                // same direction
                totalMoved += abs(diff)
            } else {
                // changed direction
                
                if threshold <= totalMoved {
                    // total moved is over threshold
                    if numberOfGestures % 2 == 0 {
                        // notification with round trip
                        delegate?.strokeViewDidStroke(self)
                    }
                    
                    numberOfGestures += 1
                }
                
                // initialize direction is changed
                totalMoved = abs(diff)
            }
        } else {
            // initialize when `isPositive` is nil
            totalMoved = abs(diff)
        }
        
        isPositive = currentIsPositive
    }
    
    /// Stroke direction
    ///
    /// - horizontal: horizontal direction
    /// - vertical: vertical direction
    public enum Direction {
        case horizontal
        case vertical
    }
    
    /// stroke direction
    public var direction: Direction = .horizontal
    
    /// handler of stroke
    public var delegate: StrokeViewDelegate?
}
