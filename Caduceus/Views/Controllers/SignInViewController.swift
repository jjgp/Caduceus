//
//  SignInViewController.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    static func button(_ title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = ctx.styleGuide.colors.buttonColor
        button.layer.cornerRadius = ctx.styleGuide.pixels.buttonRounding
        button.setTitle(title, for: .normal)
        button.setTitleColor(ctx.styleGuide.colors.buttonFont, for: .normal)
        return button
    }
    static func textField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = placeholder
        return textField
    }

    let passwordTextField = SignInViewController.textField(.t(\.password))
    let signInButton = SignInViewController.button(.t(\.signIn))
    let signUpButton = SignInViewController.button(.t(\.signUp))
    let signUpDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ctx.styleGuide.colors.line
        return view
    }()
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = ctx.styleGuide.pixels.fieldSpacing
        return stackView
    }()
    var viewModel: SignInViewModelType = SignInViewModel()
    let usernameTextField = SignInViewController.textField(.t(\.username))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ctx.styleGuide.colors.background

        addActions()
        addSubviews()
        addConstraints()
    }
}

// MARK: - Subview setup

extension SignInViewController {
    func addActions() {
        signInButton.addTarget(self, action: #selector(signIn), for: UIControl.Event.touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUp), for: UIControl.Event.touchUpInside)
    }

    func addFieldConstraints() {
        func constrainField(_ subview: UIView) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: subview,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: ctx.styleGuide.pixels.fieldHeight),
                NSLayoutConstraint(item: subview,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: verticalStackView,
                                   attribute: .width,
                                   multiplier: 1,
                                   constant: 0)
            ])
        }
        constrainField(passwordTextField)
        constrainField(usernameTextField)
        constrainField(signInButton)
        constrainField(signUpButton)
    }

    func addStackViewConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        let relatedAttributes: [(NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute)] = [
            (.centerY, .centerY), (.leading, .leadingMargin), (.trailing, .trailingMargin)
        ]
        let constraints = relatedAttributes.map {
            NSLayoutConstraint(item: verticalStackView,
                               attribute: $0.0,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: $0.1,
                               multiplier: 1,
                               constant: 0)
        }
        view.addConstraints(constraints)
    }

    func addConstraints() {
        addFieldConstraints()

        signUpDividerView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: signUpDividerView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: ctx.styleGuide.pixels.line),
            NSLayoutConstraint(item: signUpDividerView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: signUpButton,
                               attribute: .width,
                               multiplier: 1,
                               constant: 0)
        ])

        addStackViewConstraints()
    }

    func addSubviews() {
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(signInButton)
        verticalStackView.addArrangedSubview(signUpDividerView)
        verticalStackView.addArrangedSubview(signUpButton)
        view.addSubview(verticalStackView)
    }
}

// MARK: - UIButton actions

extension SignInViewController {
    @objc func signIn() {
        var isValidSignIn = true
        if !viewModel.isUsernameValid(usernameTextField.text) {
            isValidSignIn = false
        }
        if !viewModel.isPasswordValid(passwordTextField.text) {
            isValidSignIn = false
        }
        if isValidSignIn {
            viewModel.signIn(username: "", password: "")
        }
    }

    @objc func signUp() {
        viewModel.signUp()
    }
}

#if DEBUG
import SwiftUI

struct SignInViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        SignInViewController().previewWrapper
    }
}
#endif
