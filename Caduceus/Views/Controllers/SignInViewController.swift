//
//  SignInViewController.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    static func textField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        return textField
    }

    let passwordTextField = SignInViewController.textField(placeholder: .t(\.password))
    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ctx.colors.buttonColor
        button.layer.cornerRadius = 5
        button.setTitle(.t(\.signIn), for: .normal)
        button.setTitleColor(ctx.colors.buttonFont, for: .normal)
        return button
    }()
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        return stackView
    }()
    let usernameTextField = SignInViewController.textField(placeholder: .t(\.username))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ctx.colors.background
        signInButton.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)

        addSubviews()
        addConstraints()
    }
}

// MARK: - Subview setup

extension SignInViewController {
    func addSubviews() {
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(signInButton)
        view.addSubview(verticalStackView)
    }

    func addConstraints() {
        func constrainArrangedSubview(_ subview: UIView) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: subview,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 45),
                NSLayoutConstraint(item: subview,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: verticalStackView,
                                   attribute: .width,
                                   multiplier: 1,
                                   constant: 0)
            ])
        }
        constrainArrangedSubview(passwordTextField)
        constrainArrangedSubview(usernameTextField)
        constrainArrangedSubview(signInButton)

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
}

// MARK: - Submit action

extension SignInViewController {
    @objc func submit() {
        print("submit")
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
