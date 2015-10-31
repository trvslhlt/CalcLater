//
//  CalcLaterView.swift
//  CalcLater
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit

protocol CalcLaterViewDelegate: class {
    func calcLaterButtonTappedWithText(buttonText: String)
}

class CalcLaterView: UIView {

    typealias ButtonTypeContainer = CalcLaterButton.CalcButtonTypeContainer
    weak var delegate: CalcLaterViewDelegate?
    
    private let outputLabelPortion: CGFloat = 0.2
    private var gridHeight: CGFloat { get { return frame.height * (1 - outputLabelPortion) / 5 } }
    private var keyPadRect: CGRect {
        get {
            return CGRect(
                x: 0, y: outputLabelPortion * frame.height,
                width: frame.width, height: (1 - outputLabelPortion) * frame.height)
        }
    }
    
    private var clearButton: CalcLaterButton?
    private lazy var outputLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFontOfSize(38)
        label.textAlignment = .Right
        return label
    }()
    
    private lazy var buttons: [CalcLaterButton] = {
        var buttons = [CalcLaterButton]()
        for index in 1...20 {
            let button = CalcLaterButton()
            buttons.append(button)
            switch index {
            case 1:
                button.typeContainer = .Operator("ac")
                self.clearButton = button
            case 2: button.typeContainer = .Operator("+/-")
            case 3: button.typeContainer = .Operator("%")
            case 4: button.typeContainer = .Operator("/")
            case 5: button.typeContainer = .Digit("7")
            case 6: button.typeContainer = .Digit("8")
            case 7: button.typeContainer = .Digit("9")
            case 8: button.typeContainer = .Operator("x")
            case 9: button.typeContainer = .Digit("4")
            case 10: button.typeContainer = .Digit("5")
            case 11: button.typeContainer = .Digit("6")
            case 12: button.typeContainer = .Operator("-")
            case 13: button.typeContainer = .Digit("1")
            case 14: button.typeContainer = .Digit("2")
            case 15: button.typeContainer = .Digit("3")
            case 16: button.typeContainer = .Operator("+")
            case 17: button.typeContainer = .Digit("0")
            case 19: button.typeContainer = .Operator(".")
            case 20: button.typeContainer = .Operator("=")
            default: button.typeContainer = nil
            }
            self.addSubview(button)
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        }
        return buttons
    }()
    
    init(superview: UIView) {
        super.init(frame: CGRectZero)
        superview.addSubview(self)
        setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    private func updateLayout() {
        frame = superview?.bounds ?? CGRectZero
        let labelReferenceFrame = CGRect(x: 0, y: 20, width: frame.width, height: frame.height * outputLabelPortion)
        outputLabel.frame = CGRectInset(labelReferenceFrame, 10, 10)
        
        for (index, button) in buttons.enumerate() {
            let gridWidth = frame.width / 4
            let buttonWidth = index == 17 ? gridWidth * 2 : gridWidth
            button.frame = CGRect(
                x: CGFloat(index % 4) * gridWidth,
                y: keyPadRect.origin.y + CGFloat(index / 4) * gridHeight,
                width: buttonWidth,
                height: gridHeight)
        }
    }
    
    //MARK: Controller Input
    func setOutputText(outputText: String) {
        outputLabel.text = outputText
    }
    
    func setToClearAllMode(clearAll: Bool) {
        clearButton?.typeContainer = clearAll ? .Operator(CalcLaterConstants.clearAllSign) : .Operator(CalcLaterConstants.clearSign)
    }
    
    //MARK: CalcLaterViewDelegate
    func buttonTapped(button: CalcLaterButton) {
        if let typeContainer = button.typeContainer {
            switch typeContainer {
            case .Digit (let digit):
                //delegate?.calcLaterViewDigitTapped(digit)
                delegate?.calcLaterButtonTappedWithText(digit)
            case .Operator (let operatorString):
                //delegate?.calcLaterViewOperatorTapped(operatorString)
                delegate?.calcLaterButtonTappedWithText(operatorString)
            }
        }
    }
}


