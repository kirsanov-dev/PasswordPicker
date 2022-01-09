//
//  BruteForceOperation.swift
//  PasswordPicker
//
//  Created by Oleg Kirsanov on 07.01.2022.
//

import Foundation

/// Class that Inherits Operation abstract class and contains methods for picking a password.
class BruteForceOperation: Operation {
    
    // MARK: - Variables
    /// Password of type String that is passed to the instance of BruteForceOperation class in order to compare to the password generated by generatePassword method.
    private var password: String
    
    // MARK: - Init
    init(password: String) {
        self.password = password
    }
    
    /// Launches BruteForceOperation
    override func main() {
        super.main()
        if isCancelled {
            return
        }
        self.queuePriority = .low
        bruteForce(passwordToUnlock: password)
    }
    
    // MARK: - Methods
    
    /// Compares a given password to a generated string. If the generated string matches the given password, the method prints the generated string to the console.
    /// - Parameter passwordToUnlock: String value that method compares to until it completely matches it.
    private func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password = ""
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        print(password)
    }
    
    /// Gets an index of a given character (type Character) in a given array of type [String]. Returns -1 if fails to find the character.
    /// - Parameters:
    ///   - character: Character that may be in a given array.
    ///   - array: Array of strings that may contain a given character.
    /// - Returns: Position (index) of the character in the array. Returns values more or equal to zero if the character is found; returns -1 if fails.
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? -1
    }
    
    /// Gets a character at a given position (index) in a given array. Returns empty character "" if fails to find the character.
    /// - Parameters:
    ///   - index: Index in a given array.
    ///   - array: Array that may contain a character at a given position (index).
    /// - Returns: Character found at the given posotion (index).
    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }
    
    /// Generates a new string (resultString) from an array (characters) and a string (inputString) by replacing the last character.
    /// - Parameters:
    ///   - inputString: String that is changed by replacing the last character.
    ///   - characters: Source array of strings.
    /// - Returns: Generated string.
    private func generateBruteForce(_ inputString: String, fromArray characters: [String]) -> String {
        var resultString = inputString
        if resultString.count <= 0 {
            resultString.append(characterAt(index: 0, characters))
        } else {
            resultString.replace(at: resultString.count - 1, with: characterAt(index: (indexOf(character: resultString.last ?? Character(""), characters) + 1) % characters.count, characters))
            if indexOf(character: resultString.last ?? Character(""), characters) == 0 {
                resultString = String(generateBruteForce(String(resultString.dropLast()), fromArray: characters)) + String(resultString.last ?? Character(""))
            }
        }
        return resultString
    }
}




