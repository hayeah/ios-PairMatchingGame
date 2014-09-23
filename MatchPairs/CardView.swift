//
//  CardView.swift
//  MatchPairs
//
//  Created by Howard Yeh on 2014-09-20.
//  Copyright (c) 2014 Howard Yeh. All rights reserved.
//

import UIKit

private let backImage = UIImage(named: "back")!.CGImage
class CardView: UIControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

    override var selected : Bool {
        didSet {
            updateSide()
        }
    }

    var frontLayer: CALayer!
    var backLayer: CALayer!
    var card: Card? {
        didSet {
            let imgName = self.card!.imageName()
            let img = UIImage(named: imgName)!.CGImage
            self.frontLayer.contents = img
        }
    }

    override convenience init() {
        // super.init() // would this call setup? (yes!)
        self.init(frame: CGRectZero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).CGColor

        self.frontLayer = CALayer()
        // self.frontLayer.contents = UIImage(named: Card.random().imageName())!.CGImage
        self.layer.addSublayer(self.frontLayer)

        self.backLayer = CALayer()
        self.backLayer.contents = backImage
        self.layer.addSublayer(self.backLayer)

        updateSide()
    }

    override func layoutSubviews() {
        self.frontLayer.frame = CGRectInset(self.bounds,2,2)
        self.backLayer.frame = CGRectInset(self.bounds,2,2)
    }

    func showFront() {
        self.frontLayer.hidden = false
        self.backLayer.hidden = true
    }

    func showBack() {
        self.frontLayer.hidden = true
        self.backLayer.hidden = false
    }

    func updateSide() {
        if(self.selected == true) {
            self.showFront()
        } else {
            self.showBack()
        }
    }

}
