//
//  PointSlider.swift
//  CustomSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 5/14/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class PointSlider: UISlider {
    
    var sliderToolTipView: SliderToolTipView?
    
    func intializeSliderToolTipView() {
        sliderToolTipView = SliderToolTipView(frame: .zero)
        sliderToolTipView?.sliderValue = String(self.value)
        self.addSubview(self.sliderToolTipView!)
    }
    
    func updateSliderToolTipPosition()  {
        let thumbRect = self.thumbRect()
        let toolTipRect = thumbRect.offsetBy(dx: 0, dy: -thumbRect.size.height)
        sliderToolTipView?.frame = toolTipRect.insetBy(dx: 0, dy: 0)
        sliderToolTipView?.backgroundColor = UIColor.clear
        sliderToolTipView?.sliderValue = String(Int(self.value))
        //To re-draw slider text
        sliderToolTipView?.setNeedsDisplay()
    }
    
    func hideSliderToolTip() {
        sliderToolTipView?.removeFromSuperview()
    }
    
    func thumbRect() -> CGRect {
        return self.thumbRect(forBounds: self.bounds, trackRect: self.trackRect(forBounds: self.bounds), value: self.value)
    }
    
    @IBAction func valueChange(slider: UISlider) {
        slider.setValue(Float(lroundf(slider.value)), animated: true)
    }
    
    @objc func sliderValueChanged(slider: UISlider, forEvent: UIEvent) {
        //Round the Slider Value
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
            self.sliderToolTipView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.sliderToolTipView?.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.sliderToolTipView?.alpha = 1
                self.sliderToolTipView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        } else {
            self.sliderToolTipView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.sliderToolTipView?.alpha = 1
            UIView.animate(withDuration: 0.1, animations: {
                self.sliderToolTipView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (finished) in
                if(finished) {
                    self.hideSliderToolTip()
                }
            }
        }
    }
}
