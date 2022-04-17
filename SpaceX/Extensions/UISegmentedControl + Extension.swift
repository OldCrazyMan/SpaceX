//
//  UISegmentedControl + Extension.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import UIKit

extension UIViewController {
    
    func createSegmentControl(itemOne: String = "", itemTwo: String = "", selector: Selector) -> UISegmentedControl {
        let segmentControl = UISegmentedControl(items: [itemOne, itemTwo])
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .specialCellBackground
        segmentControl.selectedSegmentTintColor = .specialBigLabel
        
        let font = UIFont(name: "LabGrotesque-Bold", size: 16)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.specialCellLabel],
                                                for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.specialBackground],
                                                for: .selected)
        segmentControl.addTarget(self, action: selector, for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentControl
    }
}
