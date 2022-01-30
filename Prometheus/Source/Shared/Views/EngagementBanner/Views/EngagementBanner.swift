//
//  EngagementBanner.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/2/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol EngagementBannerNavigationDelegate {
    func performRepostNavigation(with viewModel: PostViewModelType)
}

final class EngagementBanner: UIView {
    
    private let disposeBag = DisposeBag()
    private var viewModel: EngagementBannerViewModel?
    public var navigationDelegate: EngagementBannerNavigationDelegate?
    
    
    public var textColor: UIColor {
        willSet {
            likeButton.setTextColor(newValue, forState: .normal)
            repostButton.setTextColor(newValue, forState: .normal)
            commentButton.setTextColor(newValue, forState: .normal)
            shareButton.setTextColor(newValue, forState: .normal)
        }
    }
    
    
    public var iconTintColor: UIColor {
        willSet {
            likeButton.setImageColor(newValue, forState: .normal)
            repostButton.setImageColor(newValue, forState: .normal)
            commentButton.setImageColor(newValue, forState: .normal)
            shareButton.setImageColor(newValue, forState: .normal)
        }
    }
    
    
    override var isUserInteractionEnabled: Bool {
        willSet {
            likeButton.isUserInteractionEnabled = newValue
            repostButton.isUserInteractionEnabled = newValue
            commentButton.isUserInteractionEnabled = newValue
            shareButton.isUserInteractionEnabled = newValue
        }
    }
    
    
    // MARK: - Views
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            commentButton,
            repostButton,
            likeButton,
            shareButton,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    private let likeButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.systemPink, forState: .selected)
        view.setImage(withSystemName: "heart", forState: .normal)
        view.setImage(withSystemName: "heart.fill", forState: .selected)
        view.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return view
    }()
    
    
    public let repostButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.systemGreen, forState: .selected)
        view.setImage(withSystemName: "arrowshape.turn.up.right", forState: .normal)
        view.setImage(withSystemName: "arrowshape.turn.up.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(repostButtonPressed), for: .touchUpInside)
        return view
    }()
    
    
    public let commentButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.primaryTheme, forState: .selected)
        view.setImage(withSystemName: "bubble.right", forState: .normal)
        view.setImage(withSystemName: "bubble.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        return view
    }()
    
    
    public let shareButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImage(withSystemName: "square.and.arrow.up", forState: .normal)
        view.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return view
    }()
    
    
    // MARK: - Init
    
    
    init() {
        textColor = .tertiaryTheme
        iconTintColor = .tertiaryTheme
        super.init(frame: .zero)
        backgroundColor = .clear
        fill(with: stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc private func likeButtonPressed() {
        Vibration.vibrate(with: .soft)
        viewModel?.likeButtonTapped()
    }
    
    
    @objc private func repostButtonPressed() {
        guard let viewModelForPost = viewModel?.viewModelForPost else { return }
        Vibration.vibrate(with: .soft)
        navigationDelegate?.performRepostNavigation(with: viewModelForPost)
    }
    
    
    @objc private func commentButtonPressed() {
        commentButton.isSelected = !commentButton.isSelected
    }
    
    
    @objc private func shareButtonPressed() {
        // TODO: Implement
    }
    
    
    // MARK: - Configure View Model
    
    
    public func configure(with viewModel: EngagementBannerViewModel) {
        self.viewModel = viewModel
        
        viewModel.likeButtonIsSelected.bind(onNext: {
            self.likeButton.isSelected = $0
        }).disposed(by: disposeBag)
        
        viewModel.repostButtonIsSelected.bind(onNext: {
            self.repostButton.isSelected = $0
        }).disposed(by: disposeBag)
        
        viewModel.commentButtonIsSelected.bind(onNext: {
            self.commentButton.isSelected = $0
        }).disposed(by: disposeBag)
        
        viewModel.numberOfLikes.bind(onNext: {
            self.likeButton.text = $0.roundedWithAbbreviations
        }).disposed(by: disposeBag)
        
        viewModel.numberOfReposts.bind(onNext: {
            self.repostButton.text = $0.roundedWithAbbreviations
        }).disposed(by: disposeBag)
        
        viewModel.numberOfComments.bind(onNext: {
            self.commentButton.text = $0.roundedWithAbbreviations
        }).disposed(by: disposeBag)
        
        viewModel
            .didLoadData
            .filter({ $0 == false })
            .bind(onNext: { _ in viewModel.loadInitialData() } )
            .disposed(by: disposeBag)
    }
    
}
