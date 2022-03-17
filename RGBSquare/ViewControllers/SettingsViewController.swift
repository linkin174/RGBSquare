//
//  ViewController.swift
//  RGBSquare
//
//  Created by Aleksandr Kretov on 04.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - IB Outlets

    @IBOutlet var colorView: UIView!

    @IBOutlet var redColorValue: UILabel!
    @IBOutlet var greenColorValue: UILabel!
    @IBOutlet var blueColorValue: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var grennTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    //MARK: Public Properties
    var backgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        redTF.delegate = self
        grennTF.delegate = self
        blueTF.delegate = self
        
        updateUI(using: backgroundColor)
        
        // colorValues overrides
        redColorValue.text = string(from: redSlider)
        greenColorValue.text = string(from: greenSlider)
        blueColorValue.text = string(from: blueSlider)

        // colorView overrides
        setColorViewBGColor()
        colorView.layer.cornerRadius = 16
        
        
    }

    // MARK: - IBActions

    @IBAction func doneButtonPressed() {
        delegate.setBackgroundColor(from: CGFloat(redSlider.value),
                                    green: CGFloat(greenSlider.value),
                                    blue: CGFloat(blueSlider.value))
        dismiss(animated: true)
    }
    @IBAction func slidersValuesChanged(_ sender: UISlider) {   //Из разбора
        
        switch sender {
        case redSlider:
            setTFValue(for: redTF)
            setLabelValue(for: redColorValue)
        case greenSlider:
            setTFValue(for: grennTF)
            setLabelValue(for: greenColorValue)
        default:
            setTFValue(for: blueTF)
            setLabelValue(for: blueColorValue)
        }
        setColorViewBGColor()
    }

    // MARK: - Private methods

    private func setColorViewBGColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }

    private func updateUI(using color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        setTFValue(for: redTF)
        setTFValue(for: grennTF)
        setTFValue(for: blueTF)
    }
    

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setLabelValue(for labels: UILabel...) { //Из разбора
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
    
    private func setTFValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                redTF.text = String(format: "%1.2f", redSlider.value)
            case grennTF:
                grennTF.text = String(format: "%1.2f", greenSlider.value)
            default:
                blueTF.text = String(format: "%1.2f", blueSlider.value)
            }
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == redTF {
            grennTF.becomeFirstResponder()
        } else if textField == grennTF {
            blueTF.becomeFirstResponder()
        } else {
            blueTF.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
