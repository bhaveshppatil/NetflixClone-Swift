//
//  Extensions.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 24/02/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter () -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
