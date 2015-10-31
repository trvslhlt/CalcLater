//
//  CalcLaterViewController.swift
//  CalcLater
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit


class CalcLaterViewController: UIViewController, CalcLaterViewDelegate {
    
    let calcLater = CalcLater.singleton
    lazy var calcLaterView: CalcLaterView = {
        return CalcLaterView(superview: self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcLaterView.delegate = self
        calcLater.outputUpdated = { outputText in
            self.calcLaterView.setOutputText(outputText)
            self.calcLaterView.setToClearAllMode(self.calcLater.isInClearAllMode)
        }
        calcLater.valueInput(CalcLaterConstants.initialDisplay)
    }
    
    //MARK: CalcLaterViewDelegate
    func calcLaterButtonTappedWithText(buttonText: String) {
        calcLater.valueInput(buttonText)
    }
}
