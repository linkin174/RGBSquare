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
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!

    // MARK: - Public Properties

    var backgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    // MARK: - Private Properties

   

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self

        
        
        updateUI()
    }

    // MARK: - IBActions

    @IBAction func saveButtonPressed() {
        delegate.setBackgroundColor(from: CGFloat(redSlider.value),
                                    green: CGFloat(greenSlider.value),
                                    blue: CGFloat(blueSlider.value))
        dismiss(animated: true)
    }

    @IBAction func slidersValuesChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setTextFieldValue(for: redTF)
            setLabelValue(for: redColorLabel)
        case greenSlider:
            setTextFieldValue(for: greenTF)
            setLabelValue(for: greenColorLabel)
        default:
            setTextFieldValue(for: blueTF)
            setLabelValue(for: blueColorLabel)
        }
        setColorViewBGColor()
    }
}

// MARK: - Extensions

extension SettingsViewController {
    private func showAlert() {
        let alert = UIAlertController(title: "Неверные данные",
                                      message: "Введите число в диапазоне от 0.0 до 1.0",
                                      preferredStyle: .alert)
        let closeAlertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(closeAlertAction)
        present(alert, animated: true)
    }

    private func setColorViewBGColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }

    private func updateUI() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        slidersValuesChanged(redSlider)
        
        greenSlider.value = Float(green)
        slidersValuesChanged(greenSlider)
        
        blueSlider.value = Float(blue)
        slidersValuesChanged(blueSlider)
        
        addNextButtonOnNumpad(for: redTF)
        addNextButtonOnNumpad(for: greenTF)
        addDoneButtonOnNumpad(for: blueTF)
        
        colorView.layer.cornerRadius = 16
    }

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

    private func setLabelValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel:
                redColorLabel.text = string(from: redSlider)
            case greenColorLabel:
                greenColorLabel.text = string(from: greenSlider)
            default:
                blueColorLabel.text = string(from: blueSlider)
            }
        }
    }

    private func setTextFieldValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                redTF.text = string(from: redSlider)
            case greenTF:
                greenTF.text = string(from: greenSlider)
            default:
                blueTF.text = string(from: blueSlider)
            }
        }
    }
    
    private func checkTFInput(for textField: UITextField) -> Bool {
        guard let text = textField.text,
              let value = Float(text),
              value <= 1.0 else {
            textField.text = "1.00"
            showAlert()
            return false
        }
        return true
    }

    // MARK: - Toolbar setup

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
        if checkTFInput(for: blueTF) {
            blueTF.resignFirstResponder()
        }
    }

    @objc func nextToolbarButtonPressed() {
        if redTF.isEditing, checkTFInput(for: redTF) {
            greenTF.becomeFirstResponder()
        } else if checkTFInput(for: greenTF) {
            blueTF.becomeFirstResponder()
        }
    }

    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else { return }
        switch textField {
        case redTF:
            redSlider.setValue(value, animated: true)
            slidersValuesChanged(redSlider)
        case greenTF:
            greenSlider.setValue(value, animated: true)
            slidersValuesChanged(greenSlider)
        default:
            blueSlider.setValue(value, animated: true)
            slidersValuesChanged(blueSlider)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let textFields = [redTF, greenTF, blueTF]
        textFields.forEach { item in
            guard let textField = item else { return }
            if checkTFInput(for: textField) {
                textField.endEditing(true)
            }
        }
    }
}
