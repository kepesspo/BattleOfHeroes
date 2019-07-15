//
//  StringExtensions.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/27/18.
//  Copyright © 2018 Sanoma MDC. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func localizedWith(values: CVarArg...) -> String {
        return String.init(format: NSLocalizedString(self, comment: ""), arguments: values)
    }
    
    var asParagraph: String {
            return "\n\(self)\n"
    }
    
}
