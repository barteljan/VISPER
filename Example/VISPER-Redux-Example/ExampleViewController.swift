//
//  ExampleViewController.swift
//  VISPER-Redux_Example
//
//  Created by bartel on 01.11.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER_Redux

class ExampleViewController: UIViewController {

    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    let actionDispatcher : ActionDispatcher
    
    var state : CounterState? {
        didSet {
            if let state = self.state, let counterLabel = self.counterLabel {
                counterLabel.text = String(describing: state.counter)
            }
        }
    }

    init(actionDispatcher : ActionDispatcher){
        self.actionDispatcher = actionDispatcher
        super.init(nibName: "ExampleViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        self.decrementButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
    }
    
    @objc func increment(){
        let action = IncrementAction()
        self.actionDispatcher.dispatch(action)
    }
    
    @objc func decrement() {
        let action = DecrementAction()
        self.actionDispatcher.dispatch(action)
    }

}
