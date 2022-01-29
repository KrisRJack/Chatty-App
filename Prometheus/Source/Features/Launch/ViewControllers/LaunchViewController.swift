//
//  LaunchViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/3/22.
//

import UIKit
import RxSwift


protocol LaunchNavigationDelegate {
    func presentError(message: String)
    func goToMainController(with viewModel: LaunchViewModel)
}


final class LaunchViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var navigationDelegate: LaunchNavigationDelegate?
    private var viewModel: LaunchViewModel!
    
    
    // MARK: - Views
    
    
    private let imageView: UIImageView = {
        let image = UIImage(
            systemName: "bubble.left.and.bubble.right.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 55, weight: .semibold))
        )
        let imageView = UIImageView(image: image)
        imageView.tintColor = .primaryTheme
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let logoView: LogoView = {
        let view = LogoView(fontSize: 60, alignment: .center)
        return view
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20)
        label.text = "Build together, stronger."
        return label
    }()
    
    
    // MARK: - Init
    
    
    init(with vm: LaunchViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
        setUpViews()
        
        viewModel
            .didFinishFetchingInitialBatch
            .filter({ $0 == true })
            .subscribe(onNext: { [self] _ in
                navigationDelegate?.goToMainController(with: viewModel)
            }).disposed(by: disposeBag)
        
        viewModel
            .presentErrorMessage
            .subscribe(onNext: { [self] error in
                navigationDelegate?.presentError(message: error)
            }).disposed(by: disposeBag)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchInitialFeedData()
    }
    
    
    // MARK: - PRIVATE
    
    
    private func setUpViews() {
        view.addSubviews([
            imageView,
            logoView, label
        ], withConstraints: true)
        
        [logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
         imageView.leftAnchor.constraint(equalTo: logoView.leftAnchor),
         imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
         imageView.bottomAnchor.constraint(equalTo: logoView.topAnchor, constant: -8),
         label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         label.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 12),
        ].activate()
    }
    
    
}
