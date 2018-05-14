//
//  ViewController.swift
//  CustomSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 5/3/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var slider: DisceretePointSlider!
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var pointSliderView: PointSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addTickMarks()
        pointSliderView.setupSlider(4, 10, 5)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTickMarks() {
        sliderView.subviews.forEach{if !$0.isEqual(slider){ $0.removeFromSuperview() }}
        let noOfTicks = Int(slider.maximumValue)
        for tickIndex in 0...noOfTicks {
            let trackRect = slider.trackRect(forBounds: slider.bounds)
            let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: Float(tickIndex))
            slider.addTarget(slider, action: #selector(DisceretePointSlider.sliderValueChanged(slider:forEvent:)), for: .valueChanged)
            let thumbCenterX = thumbRect.maxX
            let thumbCenterY = thumbRect.midY - 2.5
            let sliderDotView = UIView(frame: CGRect(x: thumbCenterX, y: thumbCenterY, width: 5.0, height: 5.0))
            sliderDotView.layer.cornerRadius = 3.0
            
            sliderDotView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sliderView.addSubview(sliderDotView)
        }
    }
}

