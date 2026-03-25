//
//  IconTextField.swift
//  CryptoRank
//
//  Created by Brian Kabiru on 23/03/2026.
//

import UIKit

class IconTextField: UITextField {
    
    private var toggleButton: UIButton?
    
    init(
        placeholder: String,
        leftSystemIcon: String? = nil,
        isSecure: Bool = false,
        enablePasswordToggle: Bool = false
    ) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.borderStyle = .none
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.autocapitalizationType = .none
        self.font = UIFont.systemFont(ofSize: 16)
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if let iconName = leftSystemIcon {
            let icon = UIImageView(image: UIImage(systemName: iconName))
            icon.tintColor = .gray
            icon.contentMode = .scaleAspectFit
            icon.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
            container.addSubview(icon)
            icon.center = container.center
            
            self.leftView = container
            self.leftViewMode = .always
        }
        self.isSecureTextEntry = isSecure
        
        if enablePasswordToggle {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal )
            button.tintColor = .gray
            button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            
            self.rightView = button
            self.rightViewMode = .always
            self.toggleButton = button
        }
        self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        let iconName = self.isSecureTextEntry ? "eye.slash" : "eye"
        toggleButton?.setImage(UIImage(systemName: iconName), for: .normal)
    }
    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemCyan.cgColor
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
