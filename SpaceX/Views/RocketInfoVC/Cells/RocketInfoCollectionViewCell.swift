//
//  RocketInfoTableViewCell.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import UIKit

class RocketInfoCollectionViewCell: UICollectionViewCell {
    
    private let numberLabel = UILabel(text: "229",
                                      font: .labGrotesqueBold16(),
                                      color: .specialMediumLabel)
    
    let parameterLabel = UILabel(text: "Высота, ft",
                                 font: .labGrotesqueRegular14(),
                                 color: .specialCellLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder)")
    }
    
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .specialCellBackground
        
        addSubview(numberLabel)
        addSubview(parameterLabel)
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            parameterLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 0),
            parameterLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
