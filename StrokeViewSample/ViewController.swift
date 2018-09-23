//
//  ViewController.swift
//  StrokeViewSample
//
//  Created by Kazuya Ueoka on 2018/09/23.
//  Copyright © 2018 Kazuya Ueoka. All rights reserved.
//

import UIKit
import StrokeView

class ViewController: UIViewController, StrokeViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        strokeView.delegate = self
        strokeView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.addSubview(strokeView)
        strokeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strokeView.widthAnchor.constraint(equalTo: view.widthAnchor),
            strokeView.heightAnchor.constraint(equalTo: view.heightAnchor),
            strokeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            strokeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        view.addSubview(numberOfStrokeLabel)
        numberOfStrokeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfStrokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberOfStrokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        handleNumberOfStroke()
    }
    
    lazy var numberOfStrokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var strokeView: StrokeView = StrokeView()
    
    var numberOfStroke: Int = 0 {
        didSet {
            handleNumberOfStroke()
        }
    }
    
    func strokeViewDidStroke(_ strokeView: StrokeView) {
        numberOfStroke += 1
    }
    
    private func handleNumberOfStroke() {
        numberOfStrokeLabel.text = String(numberOfStroke)
    }
}
