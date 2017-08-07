//
//  GameColorsAndObjects.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/2/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var lightGreen: UIColor {
        let red: CGFloat = 0.7
        let green: CGFloat = 1.0
        let blue: CGFloat = 0.7
        let alpha: CGFloat = 1
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    class var pink: UIColor {
        let red: CGFloat = 1.0
        let green: CGFloat = 0.7
        let blue: CGFloat = 0.7
        let alpha: CGFloat = 1
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

// TODO: Make this a utility struct (static)
struct GameColorsAndObjects {

    var gameColors = [GameColor]()
    var gameObjects = [GameObject]()
    
    init() {
        loadGameColors()
        loadGameObjects() 
    }

    mutating func loadGameColors() {
        gameColors.append(GameColor.red)
        gameColors.append(GameColor.green)
        gameColors.append(GameColor.yellow)
        gameColors.append(GameColor.blue)
        gameColors.append(GameColor.purple)
        gameColors.append(GameColor.brown)
        gameColors.append(GameColor.gray)
        gameColors.append(GameColor.orange)
        gameColors.append(GameColor.pink)
    }
    
    //consider making objects part of GameColor class
    mutating func loadGameObjects() {
        gameObjects.append(GameObject.apple)
        gameObjects.append(GameObject.banana)
        gameObjects.append(GameObject.blueberries)
        gameObjects.append(GameObject.dragonfruit)
        gameObjects.append(GameObject.grapefruit)
        gameObjects.append(GameObject.grapes)
        gameObjects.append(GameObject.kiwis)
        gameObjects.append(GameObject.orange)
        gameObjects.append(GameObject.plums)
    }
    
    //Returns a random color, excluding any color in butNot array
    func getRandomGameColor(butNot: [GameColor]?) -> GameColor {
        
        var cannotBeOneOfTheseColors: [GameColor]
        if butNot == nil {
            cannotBeOneOfTheseColors = []
        } else {
            cannotBeOneOfTheseColors = butNot!
        }
        
        var returnColor: GameColor? = nil
        
        while returnColor == nil || cannotBeOneOfTheseColors.contains(where: {$0.name == returnColor!.name}) {
            let randomIndex = Int(arc4random_uniform(UInt32(gameColors.count)))
            returnColor = gameColors[randomIndex]
        }
        return returnColor!
    }
    
    //Returns a GameObject, excluding any GameObject in butNot array
    func getRandomObject(butNot: [GameObject]?) -> GameObject {
        
        var cannotBeOneOfTheseObjects: [GameObject]
        if butNot == nil {
            cannotBeOneOfTheseObjects = []
        } else {
            cannotBeOneOfTheseObjects = butNot!
        }
        
        var returnObject: GameObject? = nil
        
        while returnObject == nil || cannotBeOneOfTheseObjects.contains(where: {$0.name == returnObject!.name}) {
            let randomIndex = Int(arc4random_uniform(UInt32(gameObjects.count)))
            returnObject = gameObjects[randomIndex]
        }
        return returnObject!
    }
    
}

    
