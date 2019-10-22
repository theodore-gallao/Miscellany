//
//  SearchHeaderCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/10/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

protocol SearchHeaderCollectionReusableViewDelegate: class {
    func searchHeaderCollectionReusableView(_ searchHeaderCollectionReusableView: SearchHeaderCollectionReusableView, didClear button: UIButton)
}

// MARK: Declaration, Data Members, & Initializers
class SearchHeaderCollectionReusableView: BaseCollectionReusableView {
    weak var delegate: SearchHeaderCollectionReusableViewDelegate?
    
    enum IndicatorStyle {
        case more
        case clear
        case none
    }
    
    var indicatorStyle: IndicatorStyle = .none {
        didSet {
            switch self.indicatorStyle {
            case .more:
                self.clearButton.alpha = 0
                self.moreArrowImageView.alpha = 1
            case .clear:
                self.clearButton.alpha = 1
                self.moreArrowImageView.alpha = 0
            case .none:
                self.clearButton.alpha = 0
                self.moreArrowImageView.alpha = 0
            }
        }
    }
    
    /// If `true`, the next time the user clears, delegate method `searchHeaderCollectionReusableViewDelegate(_ searchHeaderCollectionReusableViewDelegate: SearchHeaderCollectionReusableViewDelegate, didClear button: UIButton)` will be called. Default is false
    private var shouldClear: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.heavy)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let moreArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: UIImage.SymbolWeight.semibold)))
        imageView.tintColor = UIColor(named: "Primary")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.handleClearButton(_:)), for: .touchUpInside)
        button.tintColor = UIColor(named: "Primary")
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("  Clear  ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Constraints
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    internal var moreArrowImageViewConstraints = [NSLayoutConstraint]()
    internal var clearButtonConstraints = [NSLayoutConstraint]()
    
    // Initializer
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.moreArrowImageView)
        self.addSubview(self.clearButton)
        
        self.configureLayout()
    }
    
    // Setter
    public func set(title: String) {
        self.titleLabel.text = title
        
        self.setClear(shouldClear: false, animated: false)
    }
}

// MARK: Layout & Constraints
extension SearchHeaderCollectionReusableView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.moreArrowImageViewConstraints)
        NSLayoutConstraint.deactivate(self.clearButtonConstraints)
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        self.moreArrowImageViewConstraints = [
            self.moreArrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.moreArrowImageView.widthAnchor.constraint(equalTo: self.moreArrowImageView.widthAnchor),
            self.moreArrowImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ]
        
        self.clearButtonConstraints = [
            self.clearButton.heightAnchor.constraint(equalToConstant: 24),
            self.clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            self.clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.clearButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.moreArrowImageViewConstraints)
        NSLayoutConstraint.activate(self.clearButtonConstraints)
    }
}

// MARK: Selectors
extension SearchHeaderCollectionReusableView {
    @objc private func handleClearButton(_ sender: UIButton) {
        self.setClear(shouldClear: !self.shouldClear, animated: true)
    }
    
    private func setClear(shouldClear: Bool, animated: Bool) {
        self.shouldClear = shouldClear
        
        let title: String
        let image: UIImage?
        let backgroundColor: UIColor?
        if shouldClear {
            image = nil
            backgroundColor = UIColor(named: "Primary")
            title = "  Clear  "
        } else {
            backgroundColor = UIColor(named: "Background")
            let configuration = UIImage.SymbolConfiguration(weight: .semibold)
            image = UIImage(systemName: "xmark", withConfiguration: configuration)
            title = " "
        }
    
        if animated {
            UIView.animate(withDuration: 1 / 3) {
                self.clearButton.setImage(image, for: .normal)
                self.clearButton.setTitle(title, for: .normal)
                self.clearButton.backgroundColor = backgroundColor
                self.layoutIfNeeded()
            }
            
            if !self.shouldClear {
                self.delegate?.searchHeaderCollectionReusableView(self, didClear: self.clearButton)
            }
        } else {
            self.clearButton.setImage(image, for: .normal)
            self.clearButton.setTitle(title, for: .normal)
            self.clearButton.backgroundColor = backgroundColor
        }
    }
}
