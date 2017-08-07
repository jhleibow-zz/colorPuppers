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
        let red: CGFloat = 200.0/255.0 //0.65
        let green: CGFloat = 242.0/255.0 //1.0
        let blue: CGFloat = 175.0/255.0 //0.45
        
        let fontRed: CGFloat = 131.0/255 //0.45
        let fontGreen: CGFloat = 179.0/255.0 //0.89
        let fontBlue: CGFloat = 131.0/255.0 //0.2
        
        let alpha: CGFloat = 1
        let name: String = "green"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)
    }
    
    //Blue
    class var blue: GameColor {
        let red: CGFloat = 147.0/255.0 //0.5
        let green: CGFloat = 185.0/255.0 //0.8
        let blue: CGFloat = 204.0/255.0 //1.0
        
        let fontRed: CGFloat = 57.0/255.0 //0.3
        let fontGreen: CGFloat = 95.0/255.0 //0.6
        let fontBlue: CGFloat = 161.0/255.0 //0.89
        
        let alpha: CGFloat = 1
        let name: String = "blue"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Red
    class var red: GameColor {
        let red: CGFloat = 242.0/255.0 //1.0
        let green: CGFloat = 103.0/255.0 //0.37
        let blue: CGFloat = 97.0/255.0 //0.32

        let fontRed: CGFloat = 158.0/255.0 //0.89
        let fontGreen: CGFloat = 30.0/255.0 //0.29
        let fontBlue: CGFloat = 31.0/255.0 //0.25
        
        let alpha: CGFloat = 1
        let name: String = "red"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Orange
    class var orange: GameColor {
        let red: CGFloat = 247.0/255.0 //1.0
        let green: CGFloat = 168.0/255.0 //0.73
        let blue: CGFloat = 49.0/255.0 //0.0
        
        let fontRed: CGFloat = 230.0/255.0 //0.89
        let fontGreen: CGFloat = 86.0/255.0 //0.6
        let fontBlue: CGFloat = 33.0/255.0 //0.0
        
        let alpha: CGFloat = 1
        let name: String = "orange"
        let aOrAn: String = "an "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Yellow
    class var yellow: GameColor {
        let red: CGFloat = 246.0/255.0 //0.95
        let green: CGFloat = 211.0/255.0 //0.9
        let blue: CGFloat = 94.0/255.0 //0.0
        
        let fontRed: CGFloat = 247.0/255.0 //0.89
        let fontGreen: CGFloat = 192.0/255.0 //0.8
        let fontBlue: CGFloat = 40.0/255.0 //0.11
        
        let alpha: CGFloat = 1
        let name: String = "yellow"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Pink
    class var pink: GameColor {
        let red: CGFloat = 249.0/255.0 //1.0
        let green: CGFloat = 196.0/255.0 //0.62
        let blue: CGFloat = 202.0/255.0 //0.78
        
        let fontRed: CGFloat = 240.0/255.0 //0.93
        let fontGreen: CGFloat = 96.0/255.0 //0.5
        let fontBlue: CGFloat = 112.0/255.0 //0.72
        
        let alpha: CGFloat = 1
        let name: String = "pink"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }

    //Purple
    class var purple: GameColor {
        let red: CGFloat = 190.0/255.0 //0.85
        let green: CGFloat = 117.0/255.0 //0.61
        let blue: CGFloat = 159.0/255.0 //0.93
        
        let fontRed: CGFloat = 117.0/255.0 //0.78
        let fontGreen: CGFloat = 34.0/255.0 //0.48
        let fontBlue: CGFloat = 71.0/255.0 //0.81
        
        let alpha: CGFloat = 1
        let name: String = "purple"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }

    //Brown
    class var brown: GameColor {
        let red: CGFloat = 242.0/255.0 //0.83
        let green: CGFloat = 210.0/255.0 //0.71
        let blue: CGFloat = 163.0/255.0 //0.52
        
        let fontRed: CGFloat = 207.0/255.0 //0.75
        let fontGreen: CGFloat = 156.0/255.0 //0.55
        let fontBlue: CGFloat = 110.0/255.0 //0.35
        
        let alpha: CGFloat = 1
        let name: String = "brown"
        let aOrAn: String = "a "
        return GameColor(color: UIColor.init(red: red, green: green, blue: blue, alpha: alpha), fontColor: UIColor.init(red: fontRed, green: fontGreen, blue: fontBlue, alpha: alpha), name: name, aOrAn: aOrAn)

    }
    
    //Gray
    class var gray: GameColor {
        let red: CGFloat = 189.0/255.0 //0.79
        let green: CGFloat = 187.0/255.0 //0.79
        let blue: CGFloat = 187.0/255.0 //0.79
        
        let fontRed: CGFloat = 109.0/255.0 //0.62
        let fontGreen: CGFloat = 109.0/255.0 //0.62
        let fontBlue: CGFloat = 109.0/255.0 //0.62
        
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
