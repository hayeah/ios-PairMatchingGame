//
//  ViewController.swift
//  MatchPairs
//
//  Created by Howard Yeh on 2014-09-20.
//  Copyright (c) 2014 Howard Yeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var stepper: UIStepper!
    weak var revealButton: UIButton!
    weak var shuffleButton: UIButton!

    var cardsCount: Int {
        get {
            return self.pairsCount * 2
        }
    }

    var pairsCount: Int {
        get {
            return Int(self.stepper.value)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControls()
    }

    func setupControls() {
        let stepperFrame = CGRect(x: 113, y: 20, width: 94, height: 29)
        let revealButtonFrame = CGRect(x: 16, y: 20, width: 47, height: 30)
        let shuffleButtonFrame = CGRect(x: 256, y: 20, width: 48, height: 30)

        let stepper = UIStepper(frame: stepperFrame)
        self.stepper = stepper
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.stepValue = 1
        stepper.value = 4
        self.view.addSubview(stepper)

        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.revealButton = revealButton
        revealButton.frame = revealButtonFrame
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        self.view.addSubview(revealButton)

        let shuffleButton = UIButton.buttonWithType(.System) as UIButton
        self.shuffleButton = shuffleButton
        shuffleButton.frame = shuffleButtonFrame
        shuffleButton.setTitle("Shuffle", forState: .Normal)
        self.view.addSubview(shuffleButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

