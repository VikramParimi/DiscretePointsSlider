//
//  SliderDotView.swift
//  CustomSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 5/14/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class SliderToolTipView: UIView {
    
    var sliderValue = "0"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: 20), cornerRadius: 3.0)
        UIColor(cgColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)).setFill()
        rectanglePath.fill()
        
        let anchorPath = UIBezierPath()
        let rectMidX   = self.bounds.midX
        anchorPath.move(to: CGPoint(x: rectMidX, y: self.bounds.maxY))
        anchorPath.addLine(to: CGPoint(x: rectMidX - 5.0, y: rectanglePath.bounds.maxY))
        anchorPath.addLine(to: CGPoint(x: rectMidX + 5.0, y: rectanglePath.bounds.maxY))
        anchorPath.close()
        
        rectanglePath.append(anchorPath)
        rectanglePath.fill()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 10.0),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        let attributedString = NSAttributedString(string: sliderValue, attributes: attributes)
        
        let stringRect = CGRect(x: 0, y: 5, width: self.bounds.size.width, height: self.bounds.size.height)
        attributedString.draw(in: stringRect)
    }
}
