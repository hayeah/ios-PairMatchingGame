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
    var cardViews = [CardView]()
    var gameLayout = GameLayout()

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
        setupLayout()
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
        stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: UIControlEvents.ValueChanged)

        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.revealButton = revealButton
        revealButton.frame = revealButtonFrame
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        revealButton.addTarget(self, action: "revealAll:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(revealButton)

        let shuffleButton = UIButton.buttonWithType(.System) as UIButton
        self.shuffleButton = shuffleButton
        shuffleButton.frame = shuffleButtonFrame
        shuffleButton.setTitle("Shuffle", forState: .Normal)
        self.view.addSubview(shuffleButton)
    }

    func setupLayout() {
        var toRemove = self.cardViews.count - self.cardsCount
        while(toRemove > 0) {
            let cardView = self.cardViews.removeLast()
            cardView.removeFromSuperview()
            toRemove--
        }

        var toAdd = self.cardsCount - cardViews.count
        while(toAdd > 0) {
            let cardView = CardView() // temporary set frame to zero. Will layout properly later.
            self.view.addSubview(cardView)
            cardView.addTarget(self, action: "cardViewTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            self.cardViews.append(cardView)
            toAdd--
        }

        assert(self.cardViews.count == self.cardsCount)

        let rects = gameLayout.forPairs(self.pairsCount)
        for (i,cardView) in enumerate(self.cardViews) {
            cardView.frame = rects[i]
        }

        assignCards()
    }

    func assignCards() {
        for cardView in cardViews {
            cardView.card = Card.random()
        }
    }

    func stepperValueChanged(stepper: UIStepper) {
        setupLayout()
    }

    func cardViewTapped(cardView: CardView) {
        cardView.selected = !cardView.selected
    }

    func revealAll(button: UIButton) {
        for cardView in cardViews {
            cardView.selected = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

