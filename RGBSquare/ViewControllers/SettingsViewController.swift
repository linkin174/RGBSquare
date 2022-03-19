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
    
    //MARK: Private Properties
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    private var alpha: CGFloat = 0
    

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        redTF.delegate = self
        grennTF.delegate = self
        blueTF.delegate = self
        
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        addDoneButtonOnNumpad(for: blueTF)
        addNextButtonOnNumpad(for: redTF)
        addNextButtonOnNumpad(for: grennTF)
        
        updateUI()
        colorView.layer.cornerRadius = 16
    }

    // MARK: - IBActions

    @IBAction func doneButtonPressed() {
        delegate.setBackgroundColor(from: CGFloat(redSlider.value),
                                    green: CGFloat(greenSlider.value),
                                    blue: CGFloat(blueSlider.value))
        dismiss(animated: true)
    }
    @IBAction func slidersValuesChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setTextFieldValue(for: redTF)
            setLabelValue(for: redColorValue)
        case greenSlider:
            setTextFieldValue(for: grennTF)
            setLabelValue(for: greenColorValue)
        default:
            setTextFieldValue(for: blueTF)
            setLabelValue(for: blueColorValue)
        }
        setColorViewBGColor()
    }
}

extension SettingsViewController {
    
    private func setColorViewBGColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }

    private func updateUI() {
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)

        setTextFieldValue(for: redTF)
        setTextFieldValue(for: grennTF)
        setTextFieldValue(for: blueTF)
        
        setLabelValue(for: redColorValue)
        setLabelValue(for: greenColorValue)
        setLabelValue(for: blueColorValue)
        
        setColorViewBGColor()
    }
    

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setLabelValue(for labels: UILabel...) {
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
    
    private func setTextFieldValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                redTF.text = string(from: redSlider)
            case grennTF:
                grennTF.text = string(from: greenSlider)
            default:
                blueTF.text = string(from: blueSlider)
            }
        }
    }
    
    //MARK: Toolbar setup
    func addDoneButtonOnNumpad(for textField: UITextField) {
        let keypadToolbar = UIToolbar()
        let flexiSpace = UIBarButtonItem.flexibleSpace()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneToolbarButtonPressed))
        keypadToolbar.items = [flexiSpace, doneButton]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
    
    func addNextButtonOnNumpad(for textField: UITextField) {
        let keypadToolbar = UIToolbar()
        let flexiSpace = UIBarButtonItem.flexibleSpace()
        let nextButton = UIBarButtonItem(title: "Next",
                                         style: .plain,
                                         target: self,
                                         action: #selector(nextToolbarButtonPressed))
        keypadToolbar.items = [flexiSpace, nextButton]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }

    @objc func doneToolbarButtonPressed() {
        blueTF.resignFirstResponder()
        textFieldDidEndEditing(blueTF)
    }

    @objc func nextToolbarButtonPressed() {
        if redTF.isEditing {
            grennTF.becomeFirstResponder()
        } else {
            blueTF.becomeFirstResponder()
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTF:
            guard let value = Float(redTF.text!) else { return }
            redSlider.setValue(value, animated: true)
            slidersValuesChanged(redSlider)
        case grennTF:
            guard let value = Float(redTF.text!) else { return }
            greenSlider.setValue(value, animated: true)
            slidersValuesChanged(redSlider)
        default:
            guard let value = Float(blueTF.text!) else { return }
            blueSlider.setValue(value, animated: true)
            slidersValuesChanged(blueSlider)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
