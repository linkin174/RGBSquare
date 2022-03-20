//
//  MainViewController.swift
//  RGBSquare
//
//  Created by Aleksandr Kretov on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setBackgroundColor(with color: UIColor)
}

class MainViewController: UIViewController {
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.backgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
}
//MARK: - Extensions
extension MainViewController: SettingsViewControllerDelegate{
    func setBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
    }
}

