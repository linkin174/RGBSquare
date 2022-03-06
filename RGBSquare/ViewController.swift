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

        // colorView overrides
        setBackgroundColor()
        colorView.layer.cornerRadius = 16

        // colorValues overrides
        for label in colorLabels {
            label.text = String(format: "%.02f", sliders[0].value)
        }
    }

    // MARK: - IBActions

    @IBAction func slidersValuesChanged(_ sender: UISlider) {
        colorLabels[sender.tag].text = String(format: "%.02f", sender.value)
        setBackgroundColor()
    }

    // MARK: - Private methods

    private func setBackgroundColor() {
        let index = sliders.count - 1
        colorView.backgroundColor = UIColor(red: CGFloat(sliders[index].value),
                                            green: CGFloat(sliders[index].value),
                                            blue: CGFloat(sliders[index].value),
                                            alpha: 1)
    }
}
