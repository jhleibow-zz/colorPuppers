//
//  Square.swift
//  ColorClick
//
//  Created by John Leibowitz on 5/30/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class Square {

    
    //MARK: - Properties
    var rightAnswer: Bool
    var squareBackgroundColor: GameColor
    var squareFontColor: GameColor?
    var squareWord: GameColor?
    var squareObject: GameObject?
    
    //MARK: - Initialization
    init(rightAnswer: Bool, squareBackgroundColor: GameColor, squareFontColor: GameColor?, squareWord: GameColor?, squareObject: GameObject?) {
 
        self.rightAnswer = rightAnswer
        self.squareBackgroundColor = squareBackgroundColor
        self.squareFontColor = squareFontColor ?? GameColor.white
        self.squareWord = squareWord
        self.squareObject = squareObject
    }
    
    init() {
        self.rightAnswer = true
        self.squareBackgroundColor = GameColor.black
    }
    
    //MARK: - Public Methods
    func reset() {
        rightAnswer = true
        squareBackgroundColor = GameColor.black
        squareFontColor = GameColor.white
        squareWord = nil
        squareObject = nil
    }
    
}
