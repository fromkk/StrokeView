//
//  StrokeViewTests.swift
//  StrokeViewTests
//
//  Created by Kazuya Ueoka on 2018/09/23.
//  Copyright © 2018 Kazuya Ueoka. All rights reserved.
//

import XCTest
@testable import StrokeView

extension StrokeView.Direction {
    var aspectHorizontal: CGFloat {
        if case .horizontal = self {
            return 1.0
        } else {
            return 0.0
        }
    }
    
    var aspectVertical: CGFloat {
        if case .vertical = self {
            return 1.0
        } else {
            return 0.0
        }
    }
}

class StrokeViewTests: XCTestCase, StrokeViewDelegate {
    
    var numberOfStroke: Int = 0
    
    override func setUp() {
        super.setUp()
        
        numberOfStroke = 0
    }
    
    private func pointsOfStroke(with direction: StrokeView.Direction, threshold: CGFloat, numberOfStroke: Int) -> [CGPoint] {
        return (0..<(numberOfStroke * 4)).map { index -> CGPoint in
            if index % 4 == 0 {
                return CGPoint(
                    x: threshold * direction.aspectHorizontal * 0.0,
                    y: threshold * direction.aspectVertical * 0.0
                )
            } else if index % 4 == 1 ||  index % 4 == 3 {
                return CGPoint(
                    x: threshold * direction.aspectHorizontal / 2.0,
                    y: threshold * direction.aspectVertical / 2.0
                )
            } else {
                return CGPoint(
                    x: threshold * direction.aspectHorizontal,
                    y: threshold * direction.aspectVertical
                )
            }
        }
    }
    
    private func stroke(on strokeView: StrokeView, and points: [CGPoint]) {
        var lastPoint: CGPoint?
        points.forEach { (point) in
            defer { lastPoint = point }
            guard let lastPoint = lastPoint else { return }
            strokeView.handle(last: lastPoint, current: point)
        }
    }

    func testNotHorizontalStroke() {
        let strokeView = StrokeView()
        strokeView.direction = .horizontal
        strokeView.delegate = self
        strokeView.threshold = 100
        
        let points: [CGPoint] = pointsOfStroke(with: .horizontal, threshold: 99.0, numberOfStroke: 10)
        stroke(on: strokeView, and: points)
        
        XCTAssertEqual(0, numberOfStroke)
    }
    
    func testHorizontalStroke() {
        let strokeView = StrokeView()
        strokeView.direction = .horizontal
        strokeView.delegate = self
        strokeView.threshold = 100
        
        let points: [CGPoint] = pointsOfStroke(with: .horizontal, threshold: 100.0, numberOfStroke: 10)
        stroke(on: strokeView, and: points)
        
        XCTAssertEqual(10, numberOfStroke)
    }
    
    func testNotVerticalStroke() {
        let strokeView = StrokeView()
        strokeView.direction = .vertical
        strokeView.delegate = self
        strokeView.threshold = 100
        
        let points: [CGPoint] = pointsOfStroke(with: .vertical, threshold: 99.0, numberOfStroke: 10)
        stroke(on: strokeView, and: points)
        
        XCTAssertEqual(0, numberOfStroke)
    }
    
    func testVerticalStroke() {
        let strokeView = StrokeView()
        strokeView.direction = .vertical
        strokeView.delegate = self
        strokeView.threshold = 100
        
        let points: [CGPoint] = pointsOfStroke(with: .vertical, threshold: 100.0, numberOfStroke: 10)
        stroke(on: strokeView, and: points)
        
        XCTAssertEqual(10, numberOfStroke)
    }
    
    func strokeViewDidStroke(_ strokeView: StrokeView) {
        numberOfStroke += 1
    }

}
