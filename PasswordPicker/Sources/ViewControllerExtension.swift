//
//  ViewControllerExtension.swift
//  PasswordPicker
//
//  Created by Oleg Kirsanov on 11.01.2022.
//

import Foundation

extension ViewController {
    /// State of ViewController views
    enum State {
        case initial
        case isPicking
        case finished
    }
    
    /// Configures the views depending on its state
    func configureViews(state: State) {
        switch state {
        case .initial:
            activityIndicator.isHidden = true
            infoLabel.font = .systemFont(ofSize: labelFontSize)
            infoLabel.text = "Нажми, чтобы сгенерировать пароль"
            generateButton.backgroundColor = .systemBlue
            generateButton.tintColor = .white
            generateButton.layer.cornerRadius = cornerRadius
            switchColorButton.backgroundColor = .systemGreen
            switchColorButton.tintColor = .white
            switchColorButton.layer.cornerRadius = cornerRadius
            switchColorButton.isHidden = true
        case .isPicking:
            textField.isSecureTextEntry = true
            textField.text = String.generateString(length: passwordLength)
            infoLabel.text = "Пароль сгенерирован. Идет подбор..."
            generateButton.isUserInteractionEnabled = false
            generateButton.backgroundColor = .systemGray2
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            switchColorButton.isHidden = false
        case .finished:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            infoLabel.text = "Пароль \"\(self.textField.text ?? "")\" подобран. Попробуешь еще раз?"
            textField.isSecureTextEntry = false
            generateButton.isUserInteractionEnabled = true
            generateButton.isSelected = false
            generateButton.backgroundColor = .systemBlue
            switchColorButton.isHidden = true
        }
    }
}
