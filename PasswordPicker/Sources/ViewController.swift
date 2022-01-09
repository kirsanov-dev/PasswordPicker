//
//  ViewController.swift
//  PasswordPicker
//
//  Created by Oleg Kirsanov on 06.01.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var switchColorButton: UIButton!
    
    // MARK: - Constants and variables
    let labelFontSize: CGFloat = 12
    let cornerRadius: CGFloat = 5
    let passwordLength: Int = 3
    
    /// Indicates if the background color of the main view is black or white.
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
                self.infoLabel.textColor = .white
            } else {
                self.view.backgroundColor = .white
                self.infoLabel.textColor = .black
            }
        }
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    /// Setup initial parameters of views. Must be added to the body of viewDidLoad() method.
    func setupViews() {
        activityIndicator.isHidden = true
        infoLabel.font = .systemFont(ofSize: labelFontSize)
        infoLabel.text = "Нажми, чтобы сгенерировать пароль"
        infoLabel.textColor = .black
        generateButton.backgroundColor = .systemBlue
        generateButton.tintColor = .white
        generateButton.layer.cornerRadius = cornerRadius
        switchColorButton.backgroundColor = .systemGreen
        switchColorButton.tintColor = .white
        switchColorButton.layer.cornerRadius = cornerRadius
        switchColorButton.isHidden = true
    }

    // MARK: - Actions
    
    /// Responsible for actions after pressing generateButton button.
    /// - Parameter sender: Standard parameter passing the source of action to the method.
    @IBAction func generateButtonPressed(_ sender: Any) {
        textField.isSecureTextEntry = true
        textField.text = generatePassword(length: passwordLength)
        infoLabel.text = "Пароль сгенерирован. Идет подбор..."
        generateButton.isUserInteractionEnabled = false
        generateButton.backgroundColor = .systemGray2
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        switchColorButton.isHidden = false
        let backgroundQueue = OperationQueue()
        let bruteForceOperation = BruteForceOperation(password: textField.text ?? "")
        let mainQueue = OperationQueue.main
        let bruteForceCompletion = BlockOperation {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.infoLabel.text = "Пароль \"\(self.textField.text ?? "")\" подобран. Попробуешь еще раз?"
            self.textField.isSecureTextEntry = false
            self.generateButton.isUserInteractionEnabled = true
            self.generateButton.isSelected = false
            self.generateButton.backgroundColor = .systemBlue
            self.switchColorButton.isHidden = true
        }
        backgroundQueue.addOperation(bruteForceOperation)
        bruteForceOperation.completionBlock = {
            mainQueue.addOperation(bruteForceCompletion)
        }
    }
    
    /// Changes background color on pressing switchColor button.
    /// - Parameter sender: Standard parameter passing the source of action to the method.
    @IBAction func changeColorPressed(_ sender: Any) {
        isBlack.toggle()
    }
    
    // MARK: - Methods
    
    /// Generates random password.
    /// - Parameter length: Length of the password.
    /// - Returns: String that consists of random characters in a given range.
    func generatePassword(length: Int) -> String {
        let characters = String().letters + String().digits
        return String((0..<length).map { _ in characters.randomElement() ?? Character("") })
    }
}



