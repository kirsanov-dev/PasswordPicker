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
    let passwordLength: Int = 20
    let splitSubstringSize = 3
    
    /// State of ViewController views
    enum State {
        case initial
        case isPicking
        case finished
    }
    
    /// Indicates if the background color of the main view is black or white.
    private var isBlack: Bool = false {
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
        configureViews(state: .initial)
    }
    
    // MARK: - Actions
    /// Responsible for actions after pressing generateButton button.
    /// - Parameter sender: Standard parameter passing the source of action to the method.
    @IBAction func generateButtonPressed(_ sender: Any) {
        configureViews(state: .isPicking)
        let password = textField.text ?? ""
        let backgroundQueue = OperationQueue()
        let passwordArray = password.split(by: splitSubstringSize)
        var operations = [BruteForceOperation]()
        for passwordChunk in passwordArray {
            operations.append(BruteForceOperation(password: passwordChunk))
        }
        for operation in operations {
            backgroundQueue.addOperation(operation)
        }
        backgroundQueue.addBarrierBlock { [unowned self] in
            DispatchQueue.main.async{
                self.configureViews(state: .finished)
            }
        }
    }
    
    /// Changes background color on pressing switchColor button.
    /// - Parameter sender: Standard parameter passing the source of action to the method.
    @IBAction func changeColorPressed(_ sender: Any) {
        isBlack.toggle()
    }
    
    // MARK: - Methods
    /// Configures the views depending on its state
    func configureViews(state: State) {
        switch state {
        case .initial:
            activityIndicator.isHidden = true
            infoLabel.font = .systemFont(ofSize: labelFontSize)
            textField.font = .systemFont(ofSize: labelFontSize)
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
