//
//  GameColor.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/4/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class GameColor {
    var color: UIColor
    var fontColor: UIColor
    var name: String
    var aOrAn: String
    
    init (color: UIColor, fontColor: UIColor, name: String, aOrAn: String){
        self.color = color
        self.fontColor = fontColor
        self.name = name
        self.aOrAn = aOrAn
    }
    
    //Green
    class var green: GameColor {
        let red: CGFloat = 203.0/255.0 //0.65
        let green: CGFloat = 244.0/255.0 //1.0
        let blue: CGFloat = 187.0/255.0 //0.45
        
        let fontRed: CGFloat = 137.0/255 //0.45
        let fontGreen: CGFloat = 188.0/255.0 //0.89
        let fontBlue: CGFloat = 144.0/255.0 //0.2
        
        let alpha: CGFloat = 1
        let name: String = "green"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)
    }
    
    //Blue
    class var blue: GameColor {
        let red: CGFloat = 152.0/255.0 //0.5
        let green: CGFloat = 193.0/255.0 //0.8
        let blue: CGFloat = 209.0/255.0 //1.0
        
        let fontRed: CGFloat = 56.0/255.0 //0.3
        let fontGreen: CGFloat = 106.0/255.0 //0.6
        let fontBlue: CGFloat = 168.0/255.0 //0.89
        
        let alpha: CGFloat = 1
        let name: String = "blue"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Red
    class var red: GameColor {
        let red: CGFloat = 253.0/255.0 //1.0
        let green: CGFloat = 115.0/255.0 //0.37
        let blue: CGFloat = 111.0/255.0 //0.32

        let fontRed: CGFloat = 201.0/255.0 //0.89
        let fontGreen: CGFloat = 48.0/255.0 //0.29
        let fontBlue: CGFloat = 55.0/255.0 //0.25
        
        let alpha: CGFloat = 1
        let name: String = "red"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Orange
    class var orange: GameColor {
        let red: CGFloat = 255.0/255.0 //1.0
        let green: CGFloat = 178.0/255.0 //0.73
        let blue: CGFloat = 73.0/255.0 //0.0
        
        let fontRed: CGFloat = 242.0/255.0 //0.89
        let fontGreen: CGFloat = 97.0/255.0 //0.6
        let fontBlue: CGFloat = 49.0/255.0 //0.0
        
        let alpha: CGFloat = 1
        let name: String = "orange"
        let aOrAn: String = "an "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Yellow
    class var yellow: GameColor {
        let red: CGFloat = 255.0/255.0 //0.95
        let green: CGFloat = 226.0/255.0 //0.9
        let blue: CGFloat = 138.0/255.0 //0.0
        
        let fontRed: CGFloat = 255.0/255.0 //0.89
        let fontGreen: CGFloat = 200.0/255.0 //0.8
        let fontBlue: CGFloat = 64.0/255.0 //0.11
        
        let alpha: CGFloat = 1
        let name: String = "yellow"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Pink
    class var pink: GameColor {
        let red: CGFloat = 251.0/255.0 //1.0
        let green: CGFloat = 203.0/255.0 //0.62
        let blue: CGFloat = 208.0/255.0 //0.78
        
        let fontRed: CGFloat = 235.0/255.0 //0.93
        let fontGreen: CGFloat = 100.0/255.0 //0.5
        let fontBlue: CGFloat = 131.0/255.0 //0.72
        
        let alpha: CGFloat = 1
        let name: String = "pink"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }

    //Purple
    class var purple: GameColor {
        let red: CGFloat = 202.0/255.0 //0.85
        let green: CGFloat = 128.0/255.0 //0.61
        let blue: CGFloat = 168.0/255.0 //0.93
        
        let fontRed: CGFloat = 166.0/255.0 //0.78
        let fontGreen: CGFloat = 47.0/255.0 //0.48
        let fontBlue: CGFloat = 100.0/255.0 //0.81
        
        let alpha: CGFloat = 1
        let name: String = "purple"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }

    //Brown
    class var brown: GameColor {
        let red: CGFloat = 227.0/255.0 //0.83
        let green: CGFloat = 200.0/255.0 //0.71
        let blue: CGFloat = 176.0/255.0 //0.52
        
        let fontRed: CGFloat = 191.0/255.0 //0.75
        let fontGreen: CGFloat = 144.0/255.0 //0.55
        let fontBlue: CGFloat = 106.0/255.0 //0.35
        
        let alpha: CGFloat = 1
        let name: String = "brown"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Gray
    class var gray: GameColor {
        let red: CGFloat = 196.0/255.0 //0.79
        let green: CGFloat = 195.0/255.0 //0.79
        let blue: CGFloat = 195.0/255.0 //0.79
        
        let fontRed: CGFloat = 120.0/255.0 //0.62
        let fontGreen: CGFloat = 120.0/255.0 //0.62
        let fontBlue: CGFloat = 120.0/255.0 //0.62
        
        let alpha: CGFloat = 1
        let name: String = "gray"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Black
    class var black: GameColor {
        let red: CGFloat = 0.0
        let green: CGFloat = 0.0
        let blue: CGFloat = 0.0
        
        let fontRed: CGFloat = 0.0
        let fontGreen: CGFloat = 0.0
        let fontBlue: CGFloat = 0.0
        
        let alpha: CGFloat = 1
        let name: String = "black"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }

    //White
    class var white: GameColor {
        let red: CGFloat = 1.0
        let green: CGFloat = 1.0
        let blue: CGFloat = 1.0
        
        let fontRed: CGFloat = 1.0
        let fontGreen: CGFloat = 1.0
        let fontBlue: CGFloat = 1.0
        
        let alpha: CGFloat = 1
        let name: String = "white"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)
    }
    
    func getAssociatedObject() -> GameObject {
        switch name {
        case "blue":
            return GameObject.blueberries
        case "green":
            return GameObject.grapes
        case "red":
            return GameObject.apple
        case "yellow":
            return GameObject.banana
        case "pink":
            return GameObject.grapefruit
        case "purple":
            return GameObject.plums
        case "gray":
            return GameObject.dragonfruit
        case "orange":
            return GameObject.orange
        case "brown":
            return GameObject.kiwis
        default:
            return GameObject.kiwis
        }

    }
    
    
}
