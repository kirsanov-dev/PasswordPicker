//
//  ViewController.swift
//  PasswordPicker
//
//  Created by Oleg Kirsanov on 06.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var changeColorButton: UIButton!
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        textField.isSecureTextEntry = true
        
        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.text = "Нажмите, чтобы сгенерировать пароль"
        
        generateButton.backgroundColor = .systemBlue
        generateButton.tintColor = .white
        generateButton.layer.cornerRadius = 5
        
        changeColorButton.backgroundColor = .systemGreen
        changeColorButton.tintColor = .white
        changeColorButton.layer.cornerRadius = 5
    }

    @IBAction func generateButtonPressed(_ sender: Any) {
        textField.text = generatePassword(length: 4)
    }
    
    @IBAction func changeColorPressed(_ sender: Any) {
        isBlack.toggle()
    }
    
    func generatePassword(length: Int) -> String {
        let characters = String().printable
        return String((0..<length).map { _ in characters.randomElement()! })
    }
}

extension String {
    var digits: String { return "0123456789" }
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { return lowercase + uppercase }
    var printable: String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}



