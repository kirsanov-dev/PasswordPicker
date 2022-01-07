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
        
    }
    
    @IBAction func changeColorPressed(_ sender: Any) {
        isBlack.toggle()
    }
    
}

