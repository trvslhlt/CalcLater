//
//  CalcLaterButton.swift
//  CalcLater
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit

class CalcLaterButton: UIButton {

    var symbol: CalcLaterSymbol {
        didSet {
            setTitle(symbol.rawValue, forState: .Normal)
        }
    }
    
    init(symbol: CalcLaterSymbol) {
        self.symbol = symbol
        super.init(frame: CGRectZero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let titleText = symbol.rawValue
        setTitle(titleText, forState: .Normal)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
    }

}
