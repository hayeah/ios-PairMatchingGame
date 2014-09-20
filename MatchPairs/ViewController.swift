//
//  ViewController.swift
//  MatchPairs
//
//  Created by Howard Yeh on 2014-09-20.
//  Copyright (c) 2014 Howard Yeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControls()
    }

    func setupControls() {
        let stepper = UIStepper(frame: CGRect(x: 113, y: 20, width: 94, height: 29))
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.value = 4
        self.view.addSubview(stepper)

        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        revealButton.frame = CGRect(x: 16, y: 20, width: 47, height: 30)
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        self.view.addSubview(revealButton)

        let shuffleButton = UIButton.buttonWithType(.System) as UIButton
        shuffleButton.frame = CGRect(x: 256, y: 20, width: 48, height: 30)
        shuffleButton.setTitle("Shuffle", forState: .Normal)
        self.view.addSubview(shuffleButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

