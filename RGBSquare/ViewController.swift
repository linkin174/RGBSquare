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

    @IBOutlet var redColorValue: UILabel!
    @IBOutlet var greenColorValue: UILabel!
    @IBOutlet var blueColorValue: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // colorValues overrides
        redColorValue.text = stringFromFloat(redSlider.value)
        greenColorValue.text = stringFromFloat(greenSlider.value)
        blueColorValue.text = stringFromFloat(blueSlider.value)

        // colorView overrides
        setBackgroundColor()
        colorView.layer.cornerRadius = 16
    }

    // MARK: - IBActions

    @IBAction func slidersValuesChanged(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redColorValue.text = stringFromFloat(sender.value)
        case 1:
            greenColorValue.text = stringFromFloat(sender.value)
        default:
            blueColorValue.text = stringFromFloat(sender.value)
        }
        setBackgroundColor()
    }

    // MARK: - Private methods

    private func setBackgroundColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }

    private func stringFromFloat(_ number: Float) -> String {
        String(format: "%.02f", number)
    }
}

