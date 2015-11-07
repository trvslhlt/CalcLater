//
//  CalcLaterView.swift
//  CalcLater
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit

protocol CalcLaterViewDelegate: class {
    func calcLaterButtonTappedWithSymbol(symbol: CalcLaterSymbol)
}

class CalcLaterView: UIView {

    weak var delegate: CalcLaterViewDelegate?
    var clearConfiguration = true {
        didSet {
            clearButton?.symbol = clearConfiguration ? .ClearSign : .ClearAllSign
        }
    }
    
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
            let symbol: CalcLaterSymbol
            switch index {
            case 1: symbol = .ClearAllSign
            case 2: symbol = .NegateSign
            case 3: symbol = .PercentSign
            case 4: symbol = .DivideSign
            case 5: symbol = .Seven
            case 6: symbol = .Eight
            case 7: symbol = .Nine
            case 8: symbol = .MultiplySign
            case 9: symbol = .Four
            case 10: symbol = .Five
            case 11: symbol = .Six
            case 12: symbol = .MinusSign
            case 13: symbol = .One
            case 14: symbol = .Two
            case 15: symbol = .Three
            case 16: symbol = .PlusSign
            case 17: symbol = .Zero
            case 19: symbol = .DecimalSign
            case 20: symbol = .EqualsSign
            default: symbol = .ClearSign
            }
            let button = CalcLaterButton(symbol: symbol)
            buttons.append(button)
            self.addSubview(button)
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            if CalcLaterSymbol.ClearAllSign == symbol {
                self.clearButton = button
            }
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
        
        let buttonColumns = 4
        let emptyButtonIndex = 17
        
        for (index, button) in buttons.enumerate() {
            let gridWidth = frame.width / CGFloat(buttonColumns)
            let buttonWidth = index == emptyButtonIndex ? 0 : gridWidth
            button.frame = CGRect(
                x: CGFloat(index % buttonColumns) * gridWidth,
                y: keyPadRect.origin.y + CGFloat(index / buttonColumns) * gridHeight,
                width: buttonWidth,
                height: gridHeight)
        }
    }
    
    //MARK: Controller Input
    func setOutputText(outputText: String) {
        outputLabel.text = outputText
    }
    
    func setToClearAllMode(clearAll: Bool) {
        clearButton?.symbol = clearAll ? .ClearAllSign : .ClearSign
        
    }
    
    //MARK: CalcLaterViewDelegate
    func buttonTapped(button: CalcLaterButton) {
        delegate?.calcLaterButtonTappedWithSymbol(button.symbol)
    }
}


