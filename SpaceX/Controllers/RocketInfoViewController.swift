//
//  RockerInfoView.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import UIKit

struct OnboardingStruct {
    let image: UIImage
}

class RocketInfoViewController: UIViewController {
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .specialBackground
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.5568504333, green: 0.5567894578, blue: 0.5609448552, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pageControl.addTarget(self, action: #selector(nextImageTap), for: .touchUpInside)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .none
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let rocketInfoView = RocketInfoView()
    private let idOnbardingCell = "idOnbardingCell"
    private var onboardingArray = [OnboardingStruct]()
    private var rocketModel = Rocket()
    private var collectionViewItem = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        getRocketArray()
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnbardingCell)
        
        guard let imageFirst = UIImage(named: "FalconHeavy1-1"),
              let imageSecond = UIImage(named: "FalconHeavy1-2"),
              let imageThird = UIImage(named: "FalconHeavy1-3") else { return }
        
        let firstScreen = OnboardingStruct(image: imageFirst)
        let secondScreen = OnboardingStruct(image: imageSecond)
        let thirdScreen = OnboardingStruct(image: imageThird)
        
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    private func setupViews() {
        title = "Falcon Heavy"
        view.backgroundColor = .none
        
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
        view.addSubview(pageControl)
        scrollView.addSubview(rocketInfoView)
    }
    
    private func setDelegates() {
        rocketInfoView.settingsButtonProtocolDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getRocketArray() {
        NetworkDataFetch.shared.fetchRocket { [weak self] rocketArray, error in
            guard let self = self else { return }
            if error != nil {
                print("Error here - 01")
            } else {
                guard let rocketArray = rocketArray else { return }
                self.rocketModel = rocketArray
                print(rocketArray)
            }
        }
    }
    
    @objc private func nextImageTap() {
        if collectionViewItem < onboardingArray.count - 1 {
            collectionViewItem += 1
        } else {
            collectionViewItem = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: collectionViewItem, section: 0),
                                    at: .centeredHorizontally, animated: true)
        pageControl.currentPage = collectionViewItem
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout

extension RocketInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
}

// MARK: - SettingsButtonProtocol

extension RocketInfoViewController: SettingsButtonProtocol {
    
    func startButtonTapped() {
        let launchesViewController = LaunchesViewController()
        launchesViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(launchesViewController, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = "Назад"
    }
    
    func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .automatic
        present(settingsViewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension RocketInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnbardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
        
    }
}

//MARK: - SetConstraints

extension RocketInfoViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pageControl.heightAnchor.constraint(equalToConstant: 70),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            rocketInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 590),
            rocketInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            rocketInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9)
        ])
    }
}
