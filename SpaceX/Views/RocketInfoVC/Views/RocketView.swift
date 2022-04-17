//
//  RocketView.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import UIKit

protocol SettingsButtonProtocol: AnyObject {
    func settingsButtonTapped()
    func startButtonTapped()
}

class RocketInfoView: UIView {
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Gearshape"), for: .normal)
        
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel = UILabel(text: "Falcon Heavy",
                                    font: .labGrotesqueBold24(),
                                    color: .specialBigLabel)
    
    //MARK: - Info
    private let launchLabel = UILabel(text: "Первый запуск",
                                      font: .labGrotesqueRegular16(),
                                      color: .specialSmallLabel)
    
    private let countryLabel = UILabel(text: "Страна",
                                       font: .labGrotesqueRegular16(),
                                       color: .specialSmallLabel)
    
    private let costLabel = UILabel(text: "Стоимость запуска",
                                    font: .labGrotesqueRegular16(),
                                    color: .specialSmallLabel)
    
    private let dateLabel = UILabel(text: "7 февраля, 2018",
                                    font: .labGrotesqueRegular16(),
                                    color: .specialBigLabel)
    
    private let countryNameLabel = UILabel(text: "США",
                                           font: .labGrotesqueRegular16(),
                                           color: .specialBigLabel)
    
    private let costValueLabel = UILabel(text: "$90 млн",
                                         font: .labGrotesqueRegular16(),
                                         color: .specialBigLabel)
    
    //MARK: - "ПЕРВАЯ СТУПЕНЬ"
    
    private let firstStapLabel = UILabel(text: "ПЕРВАЯ СТУПЕНЬ",
                                         font: .labGrotesqueBold24(),
                                         color: .specialBigLabel)
    
    private let engineLabel = UILabel(text: "Количество двигателей",
                                      font: .labGrotesqueRegular16(),
                                      color: .specialSmallLabel)
    
    private let fuelLabel = UILabel(text: "Количество топлива",
                                    font: .labGrotesqueRegular16(),
                                    color: .specialSmallLabel)
    
    private let combustionTimeLabel = UILabel(text: "Время сгорания",
                                              font: .labGrotesqueRegular16(),
                                              color: .specialSmallLabel)
    
    private let engineValueLabel = UILabel(text: "27",
                                           font: .labGrotesqueRegular16(),
                                           color: .specialBigLabel)
    
    private let fuelValueLabel = UILabel(text: "308,6 ton",
                                         font: .labGrotesqueRegular16(),
                                         color: .specialBigLabel)
    
    private let combustionTimeValueLabel = UILabel(text: "593 sec",
                                                   font: .labGrotesqueRegular16(),
                                                   color: .specialBigLabel)
    
    //MARK: - "ВТОРАЯ СТУПЕНЬ"
    
    private let secondStapLabel = UILabel(text: "ВТОРАЯ СТУПЕНЬ",
                                          font: .labGrotesqueBold24(),
                                          color: .specialBigLabel)
    
    private let engineSecondLabel = UILabel(text: "Количество двигателей",
                                            font: .labGrotesqueRegular16(),
                                            color: .specialSmallLabel)
    
    private let fuelSecondLabel = UILabel(text: "Количество топлива",
                                          font: .labGrotesqueRegular16(),
                                          color: .specialSmallLabel)
    
    private let combustionTimeSecondLabel = UILabel(text: "Время сгорания",
                                                    font: .labGrotesqueRegular16(),
                                                    color: .specialSmallLabel)
    
    private let engineValueSecondLabel = UILabel(text: "27",
                                                 font: .labGrotesqueRegular16(),
                                                 color: .specialBigLabel)
    
    private let fuelValueSecondLabel = UILabel(text: "308,6 ton",
                                               font: .labGrotesqueRegular16(),
                                               color: .specialBigLabel)
    
    private let combustionTimeValueSecondLabel = UILabel(text: "593 sec",
                                                         font: .labGrotesqueRegular16(),
                                                         color: .specialBigLabel)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.bounces = false
        collectionVIew.showsHorizontalScrollIndicator = false
        collectionVIew.backgroundColor = .none
        return collectionVIew
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialCellBackground
        button.setTitle("ПОСМОТРЕТЬ ЗАПУСКИ", for: .normal)
        button.titleLabel?.font = .labGrotesqueBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var rocketModel: RocketElement?
    
    private let idRocketInfoTableViewCell = "idRocketInfoTableViewCell"
    weak var settingsButtonProtocolDelegate: SettingsButtonProtocol?
    
    var launchStackView = UIStackView()
    var countryStackView = UIStackView()
    var costStackView = UIStackView()
    
    var engineStackView = UIStackView()
    var fuelStackView = UIStackView()
    var combustionTimeStackView = UIStackView()
    
    var engineStackSecondView = UIStackView()
    var fuelStackSecondView = UIStackView()
    var combustionTimeSecondStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        setDelegate()
        setupRocketInfo()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .none
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        addSubview(nameLabel)
        addSubview(settingsButton)
        addSubview(collectionView)
        
        launchStackView = UIStackView(arrangedSubviews: [launchLabel, dateLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        countryStackView = UIStackView(arrangedSubviews: [countryLabel, countryNameLabel],
                                       axis: .horizontal,
                                       spacing: 10)
        costStackView = UIStackView(arrangedSubviews: [costLabel, costValueLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(launchStackView)
        addSubview(countryStackView)
        addSubview(costStackView)
        addSubview(firstStapLabel)
        
        engineStackView = UIStackView(arrangedSubviews: [engineLabel, engineValueLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        fuelStackView = UIStackView(arrangedSubviews: [fuelLabel, fuelValueLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        combustionTimeStackView = UIStackView(arrangedSubviews: [combustionTimeLabel, combustionTimeValueLabel],
                                              axis: .horizontal,
                                              spacing: 10)
        
        addSubview(engineStackView)
        addSubview(fuelStackView)
        addSubview(combustionTimeStackView)
        addSubview(secondStapLabel)
        
        engineStackSecondView = UIStackView(arrangedSubviews: [engineSecondLabel, engineValueSecondLabel],
                                            axis: .horizontal,
                                            spacing: 10)
        fuelStackSecondView = UIStackView(arrangedSubviews: [fuelSecondLabel, fuelValueSecondLabel],
                                          axis: .horizontal,
                                          spacing: 10)
        combustionTimeSecondStackView =  UIStackView(arrangedSubviews: [combustionTimeSecondLabel, combustionTimeValueSecondLabel],
                                                     axis: .horizontal,
                                                     spacing: 10)
        
        addSubview(engineStackSecondView)
        addSubview(fuelStackSecondView)
        addSubview(combustionTimeSecondStackView)
        addSubview(startButton)
        
        collectionView.register(RocketInfoCollectionViewCell.self, forCellWithReuseIdentifier: idRocketInfoTableViewCell)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func settingsButtonTapped() {
        settingsButtonProtocolDelegate?.settingsButtonTapped()
    }
    
    @objc private func startButtonTapped() {
        settingsButtonProtocolDelegate?.startButtonTapped()
    }
    
    private func setupRocketInfo() {
        guard let rocketModel = rocketModel else { return }
        nameLabel.text = rocketModel.name
    }
}
//MARK: - UICollectionViewDataSource

extension RocketInfoView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idRocketInfoTableViewCell, for: indexPath) as! RocketInfoCollectionViewCell
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RocketInfoView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 96,
               height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
}
//MARK: - SetConstraints

extension RocketInfoView {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 18)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            launchStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            launchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            launchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            countryStackView.topAnchor.constraint(equalTo: launchStackView.bottomAnchor, constant: 16),
            countryStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            countryStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            costStackView.topAnchor.constraint(equalTo: countryStackView.bottomAnchor, constant: 16),
            costStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            costStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            firstStapLabel.topAnchor.constraint(equalTo: costStackView.bottomAnchor, constant: 35),
            firstStapLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            firstStapLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            engineStackView.topAnchor.constraint(equalTo: firstStapLabel.bottomAnchor, constant: 16),
            engineStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            engineStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            fuelStackView.topAnchor.constraint(equalTo: engineStackView.bottomAnchor, constant: 16),
            fuelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            fuelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            combustionTimeStackView.topAnchor.constraint(equalTo: fuelStackView.bottomAnchor, constant: 16),
            combustionTimeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            combustionTimeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            secondStapLabel.topAnchor.constraint(equalTo: combustionTimeStackView.bottomAnchor, constant: 35),
            secondStapLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            secondStapLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            engineStackSecondView.topAnchor.constraint(equalTo: secondStapLabel.bottomAnchor, constant: 16),
            engineStackSecondView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            engineStackSecondView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            fuelStackSecondView.topAnchor.constraint(equalTo: engineStackSecondView.bottomAnchor, constant: 16),
            fuelStackSecondView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            fuelStackSecondView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            combustionTimeSecondStackView.topAnchor.constraint(equalTo: fuelStackSecondView.bottomAnchor, constant: 16),
            combustionTimeSecondStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            combustionTimeSecondStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: combustionTimeSecondStackView.bottomAnchor, constant: 30),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            startButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
