//
//  MyGroupsViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit


protocol MyGroupNavigationDelegate {
    func dismiss()
}

final class MyGroupsViewController: UIViewController {
    
    public var navigationDelegate: MyGroupNavigationDelegate?
    
    private var primaryButtonHeight: CGFloat { 62 }
    private var cellsPerRow: Int = UIDevice.current.orientation.isLandscape ? 4 : 2
 
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        return flowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpNavigationBar()
        view.backgroundColor = .systemBackground
        collectionView.register(MyGroupCell.self, forCellWithReuseIdentifier: MyGroupCell.reuseIdentifier)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.cellsPerRow = UIDevice.current.orientation.isLandscape ? 4 : 2
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "My Communities"
    }
    
    private func setUpViews() {
        view.addSubview(collectionView, withConstraints: true)
        [collectionView.topAnchor.constraint(equalTo: view.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         collectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ].activate()
    }
    
}

// MARK: - Collection View Data Source

extension MyGroupsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
}

// MARK: - Collection View Delegate

extension MyGroupsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGroupCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(cellsPerRow))
        
        return CGSize(width: size, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationDelegate?.dismiss()
    }
    
}
