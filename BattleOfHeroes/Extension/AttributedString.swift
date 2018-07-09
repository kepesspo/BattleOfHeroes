//
//  AttributedString.swift
//  MDCCommon
//
//  Created by Szabo Istvan on 2018. 07. 02..
//  Copyright © 2018. Sanoma MDC Kft. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    public static func regular(_ fontSize: CGFloat = 12) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }

    public static func bold(_ fontSize: CGFloat = 12) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
    }

    public static func italic(_ fontSize: CGFloat = 12) -> UIFont {
        return UIFont.italicSystemFont(ofSize: fontSize)
    }
}

public extension NSMutableAttributedString {
    /**
     Append a bold text to a mutable attributed string.
     
     Usage example:

         let text = NSMutableAttributedString()
         text.appendNormal("some regular font text")
             .appendBold("some bold text")
             .appendItalic("some italic text")

     - parameter text: the bold text
     - returns: the original attributed string with the appended bold text
     */
    @discardableResult public func appendBold(_ text: String) -> NSMutableAttributedString {
        let attributes = [NSAttributedStringKey.font: UIFont.bold()]
        let boldString = NSMutableAttributedString(string: text, attributes: attributes)
        self.append(boldString)
        return self
    }

    /**
     Append a normal text to a mutable attributed string.

     Usage example:

         let text = NSMutableAttributedString()
         text.appendNormal("some regular font text")
             .appendBold("some bold text")
             .appendItalic("some italic text")

     - parameter text: the regular font text
     - returns: the original attributed string with the appended text
     */
    @discardableResult public func appendNormal(_ text: String) -> NSMutableAttributedString {
        let attributes = [NSAttributedStringKey.font: UIFont.regular()]
        let normal = NSAttributedString(string: text, attributes: attributes)
        self.append(normal)
        return self
    }

    /**
     Append an italic text to a mutable attributed string.

     Usage example:

         let text = NSMutableAttributedString()
         text.appendNormal("some regular font text")
             .appendBold("some bold text")
             .appendItalic("some italic text")

     - parameter text: the italic text
     - returns: the original attributed string with the appended italic text
     */
    @discardableResult public func appendItalic(_ text: String) -> NSMutableAttributedString {
        let attributes = [NSAttributedStringKey.font: UIFont.italic()]
        let normal = NSAttributedString(string: text, attributes: attributes)
        self.append(normal)
        return self
    }

    /**
     Append a text with a chosen color, optional background color, optional font to a mutable attributed string.

     Usage example:

         let text = NSMutableAttributedString()
         text.normal("some regular font text")
             .appendColored(.red, "some red text")
             .appendColored(.blue, backgroundColor: .red, font: .bold(22), "some big blue text on red background")

     - parameter color: the text color
     - parameter backgroundColor (optional) the background color, clear by default
     - parameter font (optional) the font of the text, regular, size 12 by default
     - parameter text: the colored text
     - returns: the original attributed string with the appended text
     */
    @discardableResult public func appendColored(_ color: UIColor,
                                         backgroundColor: UIColor = .clear,
                                         font: UIFont = UIFont.regular(),
                                         _ text: String) -> NSMutableAttributedString {
        let attributes = [NSAttributedStringKey.font: font,
                          NSAttributedStringKey.foregroundColor: color,
                          NSAttributedStringKey.backgroundColor: backgroundColor]
        let normal = NSAttributedString(string: text, attributes: attributes)
        self.append(normal)
        return self
    }
}

