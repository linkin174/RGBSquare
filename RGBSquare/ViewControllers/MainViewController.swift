//
//  MainViewController.swift
//  RGBSquare
//
//  Created by Aleksandr Kretov on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setBackgroundColor(from red: CGFloat, green: CGFloat, blue: CGFloat)
}

class MainViewController: UIViewController {
    
    @IBOutlet var settingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.backgroundColor = self.view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate{
    func setBackgroundColor(from red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
