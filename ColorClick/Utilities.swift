//
//  Utilities.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/27/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class Utilities {
    
    //MARK: - Public Methods
    
    static func getDistributedRandomIndex(upperBoundInclusive: Int, distributionIndex: Int) -> Int {
        
        let randomDouble = getRandomDouble()
        let exponent = GamePlayParameters.StageGeneration.distributionExponent[distributionIndex]
        
        let decimal = pow(randomDouble, exponent!)
        
        return Int(floor(Double(upperBoundInclusive + 1) * decimal))
    }
    
    static func updateButtonFontSize(button: UIButton, fontName: String = GamePlayParameters.Fonts.gameFontName, scaleDownFromHeightFactor: CGFloat = 1.0) {
        
        button.titleLabel!.numberOfLines = 0
        button.titleLabel!.lineBreakMode = .byWordWrapping
        button.titleLabel!.textAlignment = .center
        
        let myParagraphStyle = NSMutableParagraphStyle()
        myParagraphStyle.headIndent = 20
        myParagraphStyle.firstLineHeadIndent = 20
        myParagraphStyle.tailIndent = -20
        myParagraphStyle.alignment = .center
        myParagraphStyle.lineBreakMode = .byWordWrapping
        
        
        let buttonHeight = button.frame.height/CGFloat(scaleDownFromHeightFactor)
        let buttonWidth = button.frame.width
        var fontSize = button.frame.width/CGFloat(GamePlayParameters.Fonts.squareSideSizeRatioToFontSize)
        var currentSizeBox: CGRect
        var widestWord:CGFloat
        
        repeat {
            //check height is ok
            let gameFont = UIFont(name: fontName, size: fontSize)
            button.titleLabel!.font = gameFont!
            let constrainedWidth = CGSize(width: buttonWidth * (1 - GamePlayParameters.Margins.marginRatioToSide), height: CGFloat.greatestFiniteMagnitude)
            let testString = NSMutableAttributedString(string: button.titleLabel!.text!)
            testString.addAttribute(NSParagraphStyleAttributeName, value: myParagraphStyle, range: NSRange(location: 0, length: testString.length))
            testString.addAttribute(NSFontAttributeName, value: gameFont!, range: NSRange(location: 0, length: testString.length))
            currentSizeBox = testString.boundingRect(with: constrainedWidth, options: .usesLineFragmentOrigin, context: nil)
            
            //check width is ok
            let wordArray = testString.string.components(separatedBy: " ")
            widestWord = 0.0
            for word in wordArray {
                let testString = NSMutableAttributedString(string: word)
                testString.addAttribute(NSParagraphStyleAttributeName, value: myParagraphStyle, range: NSRange(location: 0, length: testString.length))
                testString.addAttribute(NSFontAttributeName, value: gameFont!, range: NSRange(location: 0, length: testString.length))
                currentSizeBox = testString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude) , options: .usesLineFragmentOrigin, context: nil)
                let currentWidth = currentSizeBox.width
                if currentWidth > widestWord {
                    widestWord = currentWidth
                }
            }
            
            
            fontSize -= 0.5
        } while ((currentSizeBox.height > buttonHeight || widestWord > (buttonWidth * (1 - GamePlayParameters.Margins.marginRatioToSide))) && fontSize > 0)
        
    }
    
    static func updateLabelFont(label: UILabel, fontName: String) {
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        
        let myParagraphStyle = NSMutableParagraphStyle()
        myParagraphStyle.headIndent = 0
        myParagraphStyle.firstLineHeadIndent = 0
        myParagraphStyle.tailIndent = 0
        myParagraphStyle.alignment = .left
        myParagraphStyle.lineBreakMode = .byWordWrapping
        
        
        let labelHeight = label.frame.height
        let labelWidth = label.frame.width
        var fontSize = label.frame.width/CGFloat(GamePlayParameters.Fonts.squareSideSizeRatioToFontSize) + 20
        var currentSizeBox: CGRect
        
        repeat {
            //check height is ok
            let gameFont = UIFont(name: fontName, size: fontSize)
            label.font = gameFont!
            let constrainedWidth = CGSize(width: labelWidth * (1 - GamePlayParameters.Margins.marginRatioToSide), height: CGFloat.greatestFiniteMagnitude)
            let testString = NSMutableAttributedString(string: label.text!)
            testString.addAttribute(NSParagraphStyleAttributeName, value: myParagraphStyle, range: NSRange(location: 0, length: testString.length))
            testString.addAttribute(NSFontAttributeName, value: gameFont!, range: NSRange(location: 0, length: testString.length))
            currentSizeBox = testString.boundingRect(with: constrainedWidth, options: .usesLineFragmentOrigin, context: nil)
            
        
            
            fontSize -= 0.5
        } while (currentSizeBox.height > labelHeight && fontSize > 0)
        
    }
    
    //MARK: - Private Methods
    
    private static func getRandomDouble() -> Double {
        return Double(arc4random()) / Double(Double(UINT32_MAX) + 1)
    }
    
}
