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
        stackView.distribution = .equalSpacing
        stackView.spacing = ctx.styleGuide.pixels.fieldSpacing
        return stackView
    }()
    let usernameTextField = SignInViewController.textField(.t(\.username))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ctx.styleGuide.colors.background
        setupSubviews()
    }
}

private extension SignInViewController {
    // MARK: - Subview setup

    func setupSubviews() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpDividerView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(signInButton)
        verticalStackView.addArrangedSubview(signUpDividerView)
        verticalStackView.addArrangedSubview(signUpButton)
        view.addSubview(verticalStackView)

        let fieldHeight: CGFloat = ctx.styleGuide.pixels.fieldHeight
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: fieldHeight),
            passwordTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: fieldHeight),
            usernameTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: fieldHeight),
            signInButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
            signUpDividerView.heightAnchor.constraint(equalToConstant: ctx.styleGuide.pixels.line),
            signUpDividerView.widthAnchor.constraint(equalTo: signUpButton.widthAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: fieldHeight),
            signUpButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor)
        ])

        signInButton.addTarget(self, action: #selector(signIn), for: UIControl.Event.touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUp), for: UIControl.Event.touchUpInside)
    }
}

// MARK: - UIButton actions

extension SignInViewController {
    @objc func signIn() {
//        ctx.store.dispatch.accept(.signIn(username: usernameTextField.text!, password: passwordTextField.text!))
    }

    @objc func signUp() {}
}

#if DEBUG
import SwiftUI

struct SignInViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        SignInViewController().previewWrapper
    }
}
#endif
