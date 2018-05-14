//
//  DisceretePointSlider.swift
//  CustomSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 5/14/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class DisceretePointSlider: UISlider {

    var sliderToolTip: SliderToolTip?
    
    func intializeSliderToolTipView() {
        sliderToolTip = SliderToolTip(frame: .zero)
        sliderToolTip?.sliderValue = String(self.value)
        self.addSubview(self.sliderToolTip!)
    }
    
    func updateSliderToolTipPosition()  {
        let thumbRect = self.thumbRect()
        let toolTipRect = thumbRect.offsetBy(dx: 0, dy: -thumbRect.size.height)
        sliderToolTip?.frame = toolTipRect.insetBy(dx: 0, dy: 0)
        sliderToolTip?.backgroundColor = UIColor.clear
        sliderToolTip?.sliderValue = String(self.value)
        sliderToolTip?.setNeedsDisplay()
    }
    
    func hideSliderToolTip() {
        sliderToolTip?.removeFromSuperview()
    }
    
    func thumbRect() -> CGRect {
        return self.thumbRect(forBounds: self.bounds, trackRect: self.trackRect(forBounds: self.bounds), value: self.value)
    }
    
    @IBAction func valueChange(slider: UISlider) {
        slider.setValue(Float(lroundf(slider.value)), animated: true)
    }
    
    @objc func sliderValueChanged(slider: UISlider, forEvent: UIEvent) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        slider.setValue(Float(lroundf(slider.value)), animated: true)
        if let touchEvent = forEvent.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                let touchLocation = touchEvent.location(in: self)
                if self.thumbRect().contains(touchLocation) {
                    intializeSliderToolTipView()
                    updateSliderToolTipPosition()
                    animateSliderToolTip(expand: true)
                }
            case .moved:
                updateSliderToolTipPosition()
            case .stationary:
                updateSliderToolTipPosition()
            case .ended:
               animateSliderToolTip(expand: false)
            default:
                break
            }
        }
    }
    
    func animateSliderToolTip(expand: Bool) {
        if expand {
            self.sliderToolTip?.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.sliderToolTip?.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.sliderToolTip?.alpha = 1
                self.sliderToolTip?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        } else {
            self.sliderToolTip?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.sliderToolTip?.alpha = 1
            UIView.animate(withDuration: 0.1, animations: {
                self.sliderToolTip?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (finished) in
                if(finished) {
                    self.hideSliderToolTip()
                }
            }
        }
    }
}

class SliderToolTip: UIView {
    
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
        
        let stringRect = CGRect(x: self.bounds.origin.x + 5.0, y: self.bounds.origin.x + 5.0, width: self.bounds.size.width, height: self.bounds.size.height)
        attributedString.draw(in: stringRect)
    }
}
