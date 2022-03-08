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
        redColorValue.text = string(from: redSlider)
        greenColorValue.text = string(from: greenSlider)
        blueColorValue.text = string(from: blueSlider)

        // colorView overrides
        setBackgroundColor()
        colorView.layer.cornerRadius = 16
    }

    // MARK: - IBActions

    @IBAction func slidersValuesChanged(_ sender: UISlider) {   //Из разбора
        
        switch sender {
        case redSlider:
            setValue(for: redColorValue)
        case greenSlider:
            setValue(for: greenColorValue)
        default:
            setValue(for: blueColorValue)
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

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for labels: UILabel...) { //Из разбора
        labels.forEach { label in
            switch label {
            case redColorValue:
                redColorValue.text = string(from: redSlider)
            case greenColorValue:
                greenColorValue.text = string(from: greenSlider)
            default:
                blueColorValue.text = string(from: blueSlider)
            }
        }
    }
}

