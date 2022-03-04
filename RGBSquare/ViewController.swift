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
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // colorView overrides
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
        colorView.layer.cornerRadius = 20

        // colorValues overrides
        redValue.text = getStringFromFloat(redSlider.value)
        greenValue.text = getStringFromFloat(greenSlider.value)
        blueValue.text = getStringFromFloat(blueSlider.value)
    }

    // MARK: - IBActions

    @IBAction func redSliderValueChange() {
        redValue.text = getStringFromFloat(redSlider.value)
        setBackgroundColor()
    }

    @IBAction func greenSliderValueChange() {
        greenValue.text = getStringFromFloat(greenSlider.value)
        setBackgroundColor()
    }

    @IBAction func blueSliderValueChange() {
        blueValue.text = getStringFromFloat(blueSlider.value)
        setBackgroundColor()
    }

    // MARK: - Private methods

    private func getStringFromFloat(_ number: Float) -> String {
        String(format: "%.02f", round(number * 100) / 100)
    }

    private func setBackgroundColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
}
