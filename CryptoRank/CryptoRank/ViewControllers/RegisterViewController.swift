//
//  RegisterViewController.swift
//  CryptoRank
//
//  Created by Brian Kabiru on 18/03/2026.
//

import UIKit
import SwiftUI

class PhoneCell: UICollectionViewCell {
    static let identifier = "PhoneCell"
    
    let label = UILabel()
    let countryCodeButton = UIButton(type: .system)
    let phoneTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Phone Number"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        // Country code dropdown button
        countryCodeButton.setTitle("+254 ▼", for: .normal)
        countryCodeButton.setTitleColor(.black, for: .normal)
        countryCodeButton.layer.borderWidth = 0.5
        countryCodeButton.layer.borderColor = UIColor.lightGray.cgColor
        countryCodeButton.layer.cornerRadius = 4
        countryCodeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        countryCodeButton.addTarget(self, action: #selector(showCountryPicker), for: .touchUpInside)
        
        // Phone text field
        phoneTextField.placeholder = "712345678"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.layer.borderWidth = 0.5
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.layer.cornerRadius = 4
        phoneTextField.setLeftPadding(12)
        
        let hStack = UIStackView(arrangedSubviews: [countryCodeButton, phoneTextField])
        hStack.axis = .horizontal
        hStack.spacing = 8
        
        let vStack = UIStackView(arrangedSubviews: [label, hStack])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func showCountryPicker() {
        guard let vc = parentViewController else { return }
        
        let alert = UIAlertController(title: "Select Country Code", message: nil, preferredStyle: .actionSheet)
        
        let codes = ["+254", "+1", "+44", "+91"]
        for code in codes {
            alert.addAction(UIAlertAction(title: code, style: .default, handler: { _ in
                self.countryCodeButton.setTitle(code + " ▼", for: .normal)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = countryCodeButton
            popover.sourceRect = countryCodeButton.bounds
        }
        
        vc.present(alert, animated: true)
    }
    
    // Helper to find parent view controller
    private var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let vc = currentResponder as? UIViewController {
                return vc
            }
            responder = currentResponder.next
        }
        return nil
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

class TextFieldCell: UICollectionViewCell {
    
    static let identifier = "TextFieldCell"
    let label = UILabel()
    let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        styleTextField(textField, placeholder: "")
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.setLeftPadding(12)
        let vStack = UIStackView(arrangedSubviews: [label, textField])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
}
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
class GenderCell: UICollectionViewCell {
    static let identifier = "GenderCell"
    let label = UILabel()
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        let titles = ["Male", "Female", "Other"]
        buttons = titles.map { title in
            let button = UIButton(type: .system)
            button.setTitle("○ " + title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(genderTapped(_:)), for: .touchUpInside)
            return button
        }
        
        let hStack = UIStackView(arrangedSubviews: buttons)
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .fillEqually
        
        let vStack = UIStackView(arrangedSubviews: [label, hStack])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func genderTapped(_ sender: UIButton) {
        buttons.forEach { btn in
            if let title = btn.currentTitle?.replacingOccurrences(of: "●", with: "○") {
                btn.setTitle(title, for: .normal)
            }
        }
        if let title = sender.currentTitle?.replacingOccurrences(of: "○", with: "●") {
            sender.setTitle(title, for: .normal)
        }
        selectedButton = sender
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

class DOBCell: UICollectionViewCell {
    static let identifier = "DOBCell"
    
    let label = UILabel()
    let dobTextField = UITextField()
    let calendarButton = UIButton(type: .system)
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Date Of Birth"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        dobTextField.placeholder = "DD/MM/YYYY"
        dobTextField.borderStyle = .roundedRect
        dobTextField.inputView = datePicker
        
        calendarButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        calendarButton.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
        
        let hStack = UIStackView(arrangedSubviews: [dobTextField, calendarButton])
        hStack.axis = .horizontal
        hStack.spacing = 8
        
        let vStack = UIStackView(arrangedSubviews: [label, hStack])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func openDatePicker() {
        dobTextField.becomeFirstResponder()
    }
    
    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobTextField.text = formatter.string(from: datePicker.date)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Register ViewController
class RegisterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private let registerButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    // Gradient background
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Rounded card
    private let formCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Rounded top only
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Header labels
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal Details"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's Get Started"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Progress bar between title and subtitle
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0.5
        progress.trackTintColor = .white.withAlphaComponent(0.3)
        progress.progressTintColor = .white
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // let backItem = UIBarButtonItem()
            // backItem.title = ""
            // navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
            // navigationController?.navigationBar.tintColor = .white
        title = ""
        view.backgroundColor = .systemBackground

        setupGradientBackground()
        setupHeaderLabels()
        setupCollectionView()
        setupRegisterButton()
        setupStackView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradient = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = gradientView.bounds
        }
    }
    
    private func setupGradientBackground() {
        view.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemBlue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .systemCyan
    }

    private func setupHeaderLabels() {
        view.addSubview(titleLabel)
        view.addSubview(progressBar)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(TextFieldCell.self, forCellWithReuseIdentifier: TextFieldCell.identifier)
        collectionView.register(GenderCell.self, forCellWithReuseIdentifier: GenderCell.identifier)
        collectionView.register(PhoneCell.self, forCellWithReuseIdentifier: PhoneCell.identifier)
        collectionView.register(DOBCell.self, forCellWithReuseIdentifier: DOBCell.identifier)
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemCyan
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(registerButton)
        
        formCard.addSubview(stackView)
        view.addSubview(formCard)
        
        NSLayoutConstraint.activate([
            formCard.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            formCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            formCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: formCard.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: formCard.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: formCard.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: formCard.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // First Name, Last Name, Gender, Email, DOB, Phone
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextFieldCell.identifier,
                for: indexPath
            ) as? TextFieldCell {
                cell.label.text = "First Name"
                cell.textField.placeholder = "John"
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextFieldCell.identifier,
                for: indexPath
            ) as? TextFieldCell {
                cell.label.text = "Last Name"
                cell.textField.placeholder = "Doe"
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GenderCell.identifier,
                for: indexPath
            ) as? GenderCell {
                return cell
            }
        case 3:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextFieldCell.identifier,
                for: indexPath
            ) as? TextFieldCell {
                cell.label.text = "Email Address"
                cell.textField.placeholder = "johndoe@gmail.com"
                cell.textField.keyboardType = .emailAddress
                return cell
            }
        case 4:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DOBCell.identifier,
                for: indexPath
            ) as? DOBCell {
                return cell
            }
        case 5:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhoneCell.identifier,
                for: indexPath
            ) as? PhoneCell {
                return cell
            }
        default:
            break
        }
        // Fallback
        return UICollectionViewCell()
    }
    
    // MARK: - Register Action
    @objc private func registerTapped() {
        guard let firstNameCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? TextFieldCell,
              let firstName = firstNameCell.textField.text, !firstName.isEmpty else {
            showAlert(message: "First Name is required")
            return
        }
        
        guard let lastNameCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as? TextFieldCell,
              let lastName = lastNameCell.textField.text, !lastName.isEmpty else {
            showAlert(message: "Last Name is required")
            return
        }
        
        guard let emailCell = collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as? TextFieldCell,
              let email = emailCell.textField.text, !email.isEmpty else {
            showAlert(message: "Email Address is required")
            return
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            showAlert(message: "Please enter a valid email address")
            return
        }
        
        if let dobCell = collectionView.cellForItem(at: IndexPath(item: 4, section: 0)) as? DOBCell {
            let selectedDate = dobCell.datePicker.date
            let today = Date()
            let ageComponents = Calendar.current.dateComponents([.year], from: selectedDate, to: today)
            if let age = ageComponents.year, age < 18 {
                showAlert(message: "You must be at least 18 years old to register")
                return
            }
        }
        
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        
        let loadingAlert = AlertHelper.showLoading(on: self, message: "Registering...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            loadingAlert.dismiss(animated: true) {
                AlertHelper.showSuccess(
                    on: self,
                    message: "Account registered successfully",
                    actionTitle: "Login"
                ) {
                    let loginVC = LoginViewController()
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
            }
        }

    }
    
    private func showSuccessDialog() {
        let successAlert = UIAlertController(title: "Success", message: "Account has been registered successfully", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }))
        present(successAlert, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
