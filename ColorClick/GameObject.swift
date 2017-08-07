//
//  GameObject.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/13/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import Foundation

class GameObject {
    var name: String
    var aOrAn: String
    var objectType: String
    var naturalColor: GameColor?
    
    init (name: String, aOrAn: String, naturalColor: GameColor?, objectType: String){
        self.name = name
        self.aOrAn = aOrAn
        self.naturalColor = naturalColor
        self.objectType = objectType
    }
    
    //Blueberries
    class var blueberries: GameObject {
        let name: String = "blueberries"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.blue
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Kiwis
    class var kiwis: GameObject {
        let name: String = "kiwis"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.brown
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }

    //Dragonfruit
    class var dragonfruit: GameObject {
        let name: String = "dragonfruit"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.gray
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Grapes
    class var grapes: GameObject {
        let name: String = "grapes"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.green
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Orange
    class var orange: GameObject {
        let name: String = "oranges"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.orange
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Grapefruit
    class var grapefruit: GameObject {
        let name: String = "grapefruit"
        let aOrAn: String = "a "
        let naturalColor: GameColor = GameColor.pink
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Plums
    class var plums: GameObject {
        let name: String = "plums"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.purple
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Apple
    class var apple: GameObject {
        let name: String = "apple"
        let aOrAn: String = "an "
        let naturalColor: GameColor = GameColor.red
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
    //Banana
    class var banana: GameObject {
        let name: String = "bananas"
        let aOrAn: String = ""
        let naturalColor: GameColor = GameColor.yellow
        let objectType: String = " fruit"
        return GameObject(name: name, aOrAn: aOrAn, naturalColor: naturalColor, objectType: objectType)
    }
    
}
