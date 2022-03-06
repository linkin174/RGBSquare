//
//  ViewController.swift
//  RGBSquare
//
//  Created by Aleksandr Kretov on 04.03.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IB Outlets

    @IBOutlet var colorView: UIView!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // colorValues overrides
        for label in colorLabels {
            label.text = String(format: "%.02f", sliders[0].value)
        }

        // colorView overrides
        setBackgroundColor()
        colorView.layer.cornerRadius = 16
    }

    // MARK: - IBActions

    @IBAction func slidersValuesChanged(_ sender: UISlider) {
        colorLabels[sender.tag].text = String(format: "%.02f", sender.value)
        setBackgroundColor()
    }

    // MARK: - Private methods

    private func setBackgroundColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(sliders[0].value),
                                            green: CGFloat(sliders[1].value),
                                            blue: CGFloat(sliders[2].value),
                                            alpha: 1)
    }
}
