//
//  String.swift
//  iOnboarding
//
//  Created by Héctor Ullate on 27/12/22.
//

import Foundation

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
