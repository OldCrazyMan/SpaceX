//
//  UILabel + Extensions.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont?, color: UIColor) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
