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
    var matchedPairs: Int = 0
    var firstSelectedCardView: CardView?

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
        assignCards()
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
        shuffleButton.addTarget(self, action: "shuffleTapped:", forControlEvents: UIControlEvents.TouchUpInside)
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
    }

    func assignCards() {
        var deck = Card.fullDeck()
        shuffle(&deck)
        var pairs = [Card]()
        for i in 0..<self.pairsCount {
            let card = deck[i]
            pairs.append(card)
            pairs.append(card)
        }
        shuffle(&pairs)
        for (i,cardView) in enumerate(cardViews) {
            cardView.card = pairs[i]
        }
    }

    func hideCards() {
        for cardView in self.cardViews {
            cardView.selected = false
        }
    }

    func revealCards() {
        for cardView in cardViews {
            cardView.selected = true
        }
    }

    var ongoingShuffleAnimationsCount = 0
    func shuffleCards() {
        self.matchedPairs = 0
        self.revealCards()
        self.assignCards()
        ongoingShuffleAnimationsCount++
        UIView.animateWithDuration(1,
        animations: {
            var rects = self.gameLayout.forPairs(self.pairsCount)
            shuffle(&rects)
            for (i,cardView) in enumerate(self.cardViews) {
                cardView.frame = rects[i]
            }
        },
        completion: { completed in
            self.ongoingShuffleAnimationsCount--
            if self.ongoingShuffleAnimationsCount == 0 {
                self.hideCards()
            }
        })
    }

    func stepperValueChanged(stepper: UIStepper) {
        self.setupLayout()
        self.shuffleCards()
    }

    func foundMatchingPair(#a: CardView, b: CardView) {
        self.matchedPairs++
        if self.matchedPairs == self.pairsCount {
            self.showWinMessage()
        }
    }

    func cardViewTapped(cardView: CardView) {
        if cardView.selected {
            return
        }

        if self.firstSelectedCardView == nil {
            cardView.selected = true
            firstSelectedCardView = cardView
            return
        }

        cardView.selected = true
        var first = firstSelectedCardView!
        firstSelectedCardView = nil

        if first.card! == cardView.card! {
            foundMatchingPair(a: first, b: cardView)
        } else {
            delay(0.3) {
                cardView.selected = false
                first.selected = false
            }

        }
    }

    func shuffleTapped(button: UIButton) {
        self.shuffleCards()
    }

    func revealAll(button: UIButton) {
        self.revealCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showWinMessage() {
        let alert = UIAlertController(title: "You Won", message: "Play another game!", preferredStyle: UIAlertControllerStyle.Alert)

        let shuffle = UIAlertAction(title: "Shuffle", style: UIAlertActionStyle.Default, handler: {
            _ in
            self.shuffleCards()
        })

        alert.addAction(shuffle)

        self.presentViewController(alert, animated: true, completion: nil)
    }
}

