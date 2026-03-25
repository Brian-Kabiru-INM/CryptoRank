//
//  LoginViewController.swift
//  CryptoRank
//
//  Created by Brian Kabiru on 18/03/2026.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let usernameLabel = UILabel()
    private let passwordLabel = UILabel()
    private let usernameField = IconTextField(
    placeholder: "UserName",
    leftSystemIcon: "person")
    private let passwordField = IconTextField(
    placeholder: "Password",
    leftSystemIcon: "lock",
    isSecure: true,
    enablePasswordToggle: true)
    private let loginButton = UIButton(type: .system)
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "© 2026 CryptoRank"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        title = ""
        
        setupUI()
        loadUserDefaults()
    }
    
    private func setupUI() {
        // Logo
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Welcome Label
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        welcomeLabel.text = "Welcome Back"
        // username Label
        usernameLabel.textAlignment = .left
        usernameLabel.text = "Enter Username"
        usernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
       
        // pasword Label
        passwordLabel.textAlignment = .left
        passwordLabel.text = "Enter Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemCyan
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        // StackView
        let stackView = UIStackView(arrangedSubviews: [
            logoImageView,
            welcomeLabel,
            usernameLabel,
            usernameField,
            passwordLabel,
            passwordField,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setCustomSpacing(40, after: welcomeLabel)
        stackView.setCustomSpacing(40, after: usernameField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)
        view.addSubview(cardView)
        view.addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        
                        // Stack inside card
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
                        
                        // Footer
            footerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Validation
    @objc private func loginTapped() {
        guard let username = usernameField.text, !username.isEmpty else {
            showAlert(message: "Username cannot be empty")
            return
        }
        guard let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "Password cannot be empty")
            return
        }
        guard password.count >= 6 else {
            showAlert(message: "Password must be at least 6 characters")
            return
        }
        
        // Persist First & Last Name
        let nameParts = username.split(separator: " ")
        let firstName = nameParts.first.map(String.init) ?? ""
        let lastName = nameParts.dropFirst().first.map(String.init) ?? ""
        
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        
        showAlert(message: "Login Successful! Welcome \(firstName)")
    }
    private func styleTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemCyan.cgColor
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
        // let underline = UIView()
        // underline.backgroundColor = .lightGray
        // underline.translatesAutoresizingMaskIntoConstraints = false
        // textField.addSubview(underline)
        // NSLayoutConstraint.activate([
                    // underline.heightAnchor.constraint(equalToConstant: 1),
                    // underline.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                    // underline.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                    // underline.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4)
                // ])
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Load persisted names
    private func loadUserDefaults() {
        let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        if !firstName.isEmpty {
            welcomeLabel.text = "Welcome Back \(firstName)"
        }
    }
}
