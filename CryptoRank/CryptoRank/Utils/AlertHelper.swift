//
//  AlertHelper.swift
//  CryptoRank
//
//  Created by Brian Kabiru on 23/03/2026.
//

import UIKit

class AlertHelper {
    
    // MARK: - Error Alert
    static func showError(on vc: UIViewController, message: String) {
        let alert = UIAlertController(title: nil, message: " ", preferredStyle: .alert)
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "error"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Error"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .systemRed
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(messageLabel)
        
        alert.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20)
        ])
        
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemRed
        okButton.layer.cornerRadius = 8
        okButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        okButton.addAction(UIAction { _ in
            vc.dismiss(animated: true)
        }, for: .touchUpInside)
        
        stack.addArrangedSubview(okButton)
        
        vc.present(alert, animated: true)
    }
    
    // MARK: - Success Alert
    static func showSuccess(
        on vc: UIViewController,
        message: String,
        actionTitle: String = "Login",
        actionHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: nil, message: " ", preferredStyle: .alert)
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "success")) // custom asset
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Successful!"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle(actionTitle, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemCyan
        loginButton.layer.cornerRadius = 16
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        loginButton.addAction(UIAction { _ in
            vc.dismiss(animated: true) {
                actionHandler?()
            }
        }, for: .touchUpInside)
        
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(messageLabel)
        stack.addArrangedSubview(loginButton)
        
        alert.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20)
        ])
        
        vc.present(alert, animated: true)
    }
    
    // MARK: - Loading Alert
    static func showLoading(on vc: UIViewController, message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: " ", preferredStyle: .alert) // placeholder
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        stack.addArrangedSubview(spinner)
        stack.addArrangedSubview(label)
        
        alert.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20)
        ])
        
        vc.present(alert, animated: true)
        return alert
    }
}
