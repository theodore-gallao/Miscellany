//
//  UserFormViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/23/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import Combine

class UserFormViewController: UIViewController {
    private(set) var user: User
    
    let userService: UserService
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 64
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(named: "Subtext") ?? UIColor.secondaryLabel])
        textField.attributedPlaceholder = attributedPlaceholder
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.keyboardType = .alphabet
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(named: "Subtext") ?? UIColor.secondaryLabel])
        textField.attributedPlaceholder = attributedPlaceholder
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.keyboardType = .alphabet
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var notNowButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Not Now", style: .plain, target: self, action: #selector(self.handleNotNowBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var nextButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.handleNextBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    init(user: User, userService: UserService = .shared) {
        self.user = user
        self.userService = userService
        
        super.init(nibName: nil, bundle: nil)
        
        self.firstNameTextField.text = user.firstName
        self.lastNameTextField.text = user.lastName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserFormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.firstNameTextField)
        self.scrollView.addSubview(self.lastNameTextField)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.imageView.heightAnchor.constraint(equalToConstant: 128),
            self.imageView.widthAnchor.constraint(equalToConstant: 128),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.firstNameTextField.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.firstNameTextField.heightAnchor.constraint(equalToConstant: 44),
            self.firstNameTextField.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.firstNameTextField.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor),
            self.lastNameTextField.heightAnchor.constraint(equalToConstant: 44),
            self.lastNameTextField.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.lastNameTextField.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.lastNameTextField.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "My Info"
        self.navigationItem.setHidesBackButton(true, animated: animated)
        self.navigationItem.setLeftBarButton(self.notNowButton, animated: animated)
        self.navigationItem.setRightBarButton(self.nextButton, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: keyboardSize.height)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: Selectors
extension UserFormViewController {
    @objc private func handleNotNowBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleNextBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
}
