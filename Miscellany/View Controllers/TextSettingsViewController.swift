//
//  TextOptionsViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/18/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

/// This delegate will listen to changes done to `TextSettings` by `TextSettingsViewController`
protocol TextSettingsViewControllerDelegate {
    
    /// This method notifies this delegate that `TextSettingsViewController` has changed the `textSize` property of `TextSettings`
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextSize to: CGFloat)
    
    /// This method notifies this delegate that `TextSettingsViewController` has changed the `textFont` property of `TextSettings`
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextFontType to: TextSettings.FontType)
    
    /// This method notifies this delegate that `TextSettingsViewController` has changed the `lineSpacing` property of `TextSettings`
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeLineSpacing to: TextSettings.LineSpacing)
}

/// This view controller is used to view and change the user's `TextSettings`.
class TextSettingsViewController: UIViewController {
    
    // MARK: Data Members
    /// This delegate listens to any changes done to TextSettings by this TextSettingsViewController
    var delegate: TextSettingsViewControllerDelegate?
    
    /// The TextSettings object to be modified and observed
    private(set) var textSettings: TextSettings
    
    // MARK: Views
    /// The blur effect view that will effectively be the background of this `UIViewController`
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        return blurEffectView
    }()
    
    /// Indicator at the top of this `UIViewController` to indicate that this is a draggable
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Text")?.withAlphaComponent(1 / 3)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Segmented control that modifies the `lineSpacing` property of `TextSettings`
    private lazy var lineSpacingSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(
            items: [
                UIImage(named: "Compact Spacing")!,
                UIImage(named: "Standard Spacing")!,
                UIImage(named: "Extra Spacing")!])
        segmentedControl.addTarget(self, action: #selector(self.handleLineSpacingSegmentedControl(_:)), for: UIControl.Event.valueChanged)
        segmentedControl.selectedSegmentIndex = TextSettings.LineSpacing.allCases.firstIndex(of: self.textSettings.lineSpacing) ?? 1
        segmentedControl.apportionsSegmentWidthsByContent = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    private lazy var fontPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(self.textSettings.textFontIndex, inComponent: 0, animated: false)
        pickerView.selectRow(Int(self.textSettings.textSize) - 10, inComponent: 1, animated: false)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    // MARK: Initializers
    init(textSettings: TextSettings) {
        self.textSettings = textSettings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.textSettings = TextSettings()
        
        super.init(coder: coder)
    }
    
    // MARK: View Controller States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.blurEffectView)
        self.view.addSubview(self.dragIndicatorView)
        self.view.addSubview(self.lineSpacingSegmentedControl)
        self.view.addSubview(self.fontPickerView)
        
        self.configureLayout()
    }
    
    // MARK: Layout & Constraints
    internal var blurEffectViewConstraints = [NSLayoutConstraint]()
    internal var dragIndicatorViewConstraints = [NSLayoutConstraint]()
    internal var lineSpacingSegmentedControlConstraints = [NSLayoutConstraint]()
    internal var fontPickerViewConstraints = [NSLayoutConstraint]()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    /// The main method to configure the layout of all subviews
    internal func configureLayout() {
        NSLayoutConstraint.deactivate(self.blurEffectViewConstraints)
        NSLayoutConstraint.deactivate(self.dragIndicatorViewConstraints)
        NSLayoutConstraint.deactivate(self.lineSpacingSegmentedControlConstraints)
        NSLayoutConstraint.deactivate(self.fontPickerViewConstraints)
        
        self.blurEffectViewConstraints = [
            self.blurEffectView.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 0),
            self.blurEffectView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 0),
            self.blurEffectView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 0),
            self.blurEffectView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: 0)
        ]
        
        self.dragIndicatorViewConstraints = [
            self.dragIndicatorView.heightAnchor.constraint(
                equalToConstant: 5),
            self.dragIndicatorView.widthAnchor.constraint(
                equalToConstant: 36),
            self.dragIndicatorView.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 8),
            self.dragIndicatorView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor,
                constant: 0)
        ]
        
        self.lineSpacingSegmentedControlConstraints = [
            self.lineSpacingSegmentedControl.heightAnchor.constraint(
                equalToConstant: 44),
            self.lineSpacingSegmentedControl.widthAnchor.constraint(
                equalTo: self.view.widthAnchor,
                multiplier: 0.5),
            self.lineSpacingSegmentedControl.topAnchor.constraint(
                equalTo: self.dragIndicatorView.bottomAnchor,
                constant: 10),
            self.lineSpacingSegmentedControl.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor,
                constant: 0),
        ]
        
        self.fontPickerViewConstraints = [
            self.fontPickerView.topAnchor.constraint(
                equalTo: self.lineSpacingSegmentedControl.bottomAnchor,
                constant: 0),
            self.fontPickerView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor,
                constant: 0),
            self.fontPickerView.widthAnchor.constraint(
                equalTo: self.view.layoutMarginsGuide.widthAnchor,
                multiplier: 1),
            self.fontPickerView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -16)
        ]
        
        NSLayoutConstraint.activate(self.blurEffectViewConstraints)
        NSLayoutConstraint.activate(self.dragIndicatorViewConstraints)
        NSLayoutConstraint.activate(self.lineSpacingSegmentedControlConstraints)
        NSLayoutConstraint.activate(self.fontPickerViewConstraints)
    }
}

// MARK: Picker View Data Source
extension TextSettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return TextSettings.FontType.allCases.count
        } else {
            return 21
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return pickerView.frame.width * 0.75
        } else {
            return pickerView.frame.width * 0.25
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            let fontType = TextSettings.FontType.allCases[optional: row] ?? .default
            let font = self.textSettings.font(type: fontType)
            let name = fontType == .default ? "Default" : font?.familyName ?? "Unknown"
            
            let label = view as? UILabel ?? UILabel()
            label.font = font?.withSize(22)
            label.textColor = UIColor(named: "Text")
            label.textAlignment = .center
            label.text = name
            
            return label
        } else {
            let label = view as? UILabel ?? UILabel()
            label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.regular)
            label.textColor = UIColor(named: "Text")
            label.textAlignment = .center
            label.text = "\(10 + row)"
            
            return label
        }
    }
}

// MARK: Picker View Delegate
extension TextSettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.textSettings.textFontType = TextSettings.FontType.allCases[optional: row] ?? .default
            self.delegate?.textSettingsViewController(
                self,
                textSettings: self.textSettings,
                didChangeTextFontType: self.textSettings.textFontType)
        } else {
            self.textSettings.textSize = CGFloat(row + 10)
            self.delegate?.textSettingsViewController(
                self,
                textSettings: self.textSettings,
                didChangeTextSize: self.textSettings.textSize)
        }
    }
}

// MARK: Selectors
extension TextSettingsViewController {
    @objc private func handleLineSpacingSegmentedControl(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.textSettings.lineSpacing = .compact
        case 1:
            self.textSettings.lineSpacing = .standard
        case 2:
            self.textSettings.lineSpacing = .extra
        default:
            self.textSettings.lineSpacing = .standard
        }
        
        self.delegate?.textSettingsViewController(self, textSettings: self.textSettings, didChangeLineSpacing: self.textSettings.lineSpacing)
    }
}
