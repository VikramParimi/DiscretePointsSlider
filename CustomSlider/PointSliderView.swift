//
//  PointSliderView.swift
//  CustomSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 5/14/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class PointSliderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var slider: PointSlider!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addTickMarks()
    }
    
    func setup() {
        let view = loadViewfromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewfromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setupSlider(_ minimumValue: Float, _ maximumValue: Float, _ currentValue: Float) {
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.value        = currentValue
    }
    
    func addTickMarks() {
        self.layoutIfNeeded()
        let noOfTicks = Int(slider.maximumValue)
        for tickIndex in 0...noOfTicks {
            let trackRect = slider.trackRect(forBounds: slider.bounds)
            let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: Float(tickIndex))
            slider.addTarget(slider, action: #selector(DisceretePointSlider.sliderValueChanged(slider:forEvent:)), for: .valueChanged)
            let thumbCenterX = thumbRect.maxX
            let thumbCenterY = thumbRect.midY - 2
            let sliderDotView = UIView(frame: CGRect(x: thumbCenterX, y: thumbCenterY, width: 5.0, height: 5.0))
            sliderDotView.layer.cornerRadius = 3.0
            sliderDotView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.addSubview(sliderDotView)
        }
    }
}
