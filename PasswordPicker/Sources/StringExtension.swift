//
//  StringExtension.swift
//  PasswordPicker
//
//  Created by Oleg Kirsanov on 08.01.2022.
//

import Foundation

extension String {
    /// Contains numbers from 0 to 9.
    var digits: String { return "0123456789" }
    /// Contains lowercase letters from a to z.
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    /// Contains uppercasel letters from A to Z.
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    /// Contains  punctuation symbols.
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    /// Contains all lowercase and uppercase letters.
    var letters: String { return lowercase + uppercase }
    /// Contains: lowercase letters, uppercase letters, numbers and punctuation symbols.
    var printable: String { return digits + letters + punctuation }

    /// Replaces a character in a String at a given position.
    /// - Parameters:
    ///   - index: Position (index) of a character in the string that must be replaced.
    ///   - character: Character that must be inserted at a given position (index).
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
    
    /// Splits a string into substrings of given length.
    /// - Parameter length: Length of substrings.
    /// - Returns: Array of substrings.
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map { String($0) }
    }
    
    /// Generates random password.
    /// - Parameter length: Length of the password.
    /// - Returns: String that consists of random characters in a given range.
    static func generateString(length: Int) -> String {
        let characters = String().printable
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}
