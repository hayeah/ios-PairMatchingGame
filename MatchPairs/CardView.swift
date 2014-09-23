//
//  CardView.swift
//  MatchPairs
//
//  Created by Howard Yeh on 2014-09-20.
//  Copyright (c) 2014 Howard Yeh. All rights reserved.
//

import UIKit

class CardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    var frontLayer: CALayer!

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
        self.frontLayer.contents = UIImage(named: "ace_of_spades")!.CGImage
        self.layer.addSublayer(self.frontLayer)
    }

    override func layoutSubviews() {
        self.frontLayer.frame = CGRectInset(self.bounds,2,2)
    }

}
