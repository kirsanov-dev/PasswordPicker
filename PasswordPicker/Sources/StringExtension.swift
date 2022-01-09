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
}
