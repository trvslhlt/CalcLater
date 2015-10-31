//
//  CalcLaterButton.swift
//  CalcLater
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit

class CalcLaterButton: UIButton {
    
    enum CalcButtonTypeContainer {
        case Digit(String)
        case Operator(String)
    }
    
    var typeContainer: CalcButtonTypeContainer? {
        didSet {
            if let typeContainer = typeContainer {
                let titleText: String
                switch typeContainer {
                case .Digit(let digit):
                    titleText = digit
                    setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                case .Operator(let operatorString):
                    titleText = operatorString
                    setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                }
                setTitle("\(titleText)", forState: .Normal)
            } else {
                setTitle("", forState: .Normal)
            }
            
        }
    }

}
