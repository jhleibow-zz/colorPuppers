//
//  MiniGame.swift
//  ColorClick
//
//  Created by John Leibowitz on 5/30/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//


import UIKit


class MiniGame {
    
    //MARK: - Properties
    let defaultNumberOfSquares = 4
    
    var squareCollection = [Square]()
    var numberOfSquares: Int
    
    var instructions: NSMutableAttributedString?
    var timeToSolve: Float?
    
    var gameColorsAndObjects = GameColorsAndObjects()
    var miniGameStage = MiniGameStage()
    
    var backgroundUpdated = false
    var wordUpdated = false
    var fontColorUpdated = false
    var objectUpdated = false
    
    
    private var answerIndex:Int?

    
    //MARK: - Initialization
    init(numberOfSquares: Int) {
        self.numberOfSquares = numberOfSquares
        for _ in 0..<numberOfSquares {
            squareCollection.append(Square())
        }
    }
    
    init() {
        self.numberOfSquares = defaultNumberOfSquares
        for _ in 0..<numberOfSquares {
            squareCollection.append(Square())
        }
    }
    
    //MARK: - Public Methods
    
    func updateMiniGame(gameSession: GameSession)  {

        backgroundUpdated = false
        wordUpdated = false
        fontColorUpdated = false
        objectUpdated = false
        
        miniGameStage = MiniGameStage(gameSession: gameSession)
        resetSquares()
        setTimeToSolve(gameSession: gameSession)
        setAnswerIndex() //sets the index for the answer square (for nots this is the only square that's a wrong answer)
        updateInstructionsAndSetChosenColor()
        updateSquares()
    }
    
    
    //MARK: - Private Methods
    
    
    //sets time to solve based on level and difficulty
    private func setTimeToSolve(gameSession: GameSession)  {
        
        var difficultyMultiplier: Float
        
        switch gameSession.currentDifficulty! {
        case GameSession.Difficulty.easy:
            difficultyMultiplier = GamePlayParameters.Timing.easyDifficultyMultiplier
        case GameSession.Difficulty.medium:
            difficultyMultiplier = GamePlayParameters.Timing.mediumDifficultyMultiplier
        case GameSession.Difficulty.hard:
            difficultyMultiplier = GamePlayParameters.Timing.hardDifficultyMultiplier
        }
        
        timeToSolve = (difficultyMultiplier * GamePlayParameters.Timing.minigameStandardTime) - (Float(gameSession.getCurrentLevel()) * GamePlayParameters.Timing.levelTimeReducer)
        
        if timeToSolve! < GamePlayParameters.Timing.minimumTime {
            timeToSolve = GamePlayParameters.Timing.minimumTime
        }
    }
    
    private func resetSquares() {
        for aSquare in squareCollection {
            aSquare.reset()
        }
    }
    
    private func setAnswerIndex() {
        
        let minigameIsANegative = miniGameStage.notHaveBackground || miniGameStage.notHaveWord || miniGameStage.notHaveObject || miniGameStage.notHaveFontColor || miniGameStage.notHaveObjectColor
        
        answerIndex = Int(arc4random_uniform(UInt32(squareCollection.count)))
        
        squareCollection[answerIndex!].rightAnswer = !minigameIsANegative
        for index in 0..<squareCollection.count {
            if index != answerIndex! {
                squareCollection[index].rightAnswer = minigameIsANegative
            }
        }
        
    }
    
    private func updateInstructionsAndSetChosenColor() {
        
        var subjectString1 = ""
        var colorDescriptor1 = ""
        var aOrAn = ""
        var withOrThatSays = ""
        var subjectColor = GameColor.white
        
        if miniGameStage.hasBackground {
            subjectString1 = " background"
            miniGameStage.chosenBackgroundColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            colorDescriptor1 = miniGameStage.chosenBackgroundColor!.name
            subjectColor = miniGameStage.chosenBackgroundColor!
            aOrAn = miniGameStage.chosenBackgroundColor!.aOrAn
            withOrThatSays = "with "
        }

        if miniGameStage.notHaveBackground {
            subjectString1 = " background"
            miniGameStage.chosenBackgroundColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            colorDescriptor1 = miniGameStage.chosenBackgroundColor!.name
            subjectColor = miniGameStage.chosenBackgroundColor!
            aOrAn = miniGameStage.chosenBackgroundColor!.aOrAn
            withOrThatSays = "that does not have "
        }
        
        //assumes object has no color
        if miniGameStage.hasObject {
            miniGameStage.chosenObject = gameColorsAndObjects.getRandomObject(butNot: nil)
            subjectString1 = miniGameStage.chosenObject!.name
            colorDescriptor1 = ""
            subjectColor = miniGameStage.chosenObject!.naturalColor!
            aOrAn = miniGameStage.chosenObject!.aOrAn
            withOrThatSays = "with "
        }
        
        //assumes object has no color
        if miniGameStage.notHaveObject {
            miniGameStage.chosenObject = gameColorsAndObjects.getRandomObject(butNot: nil)
            subjectString1 = miniGameStage.chosenObject!.name
            colorDescriptor1 = ""
            subjectColor = miniGameStage.chosenObject!.naturalColor!
            aOrAn = miniGameStage.chosenObject!.aOrAn
            withOrThatSays = "that does not have "
        }
        
        if miniGameStage.hasObjectColor {
            //this doesn't deal with multicolored objects yet
            miniGameStage.chosenObject = gameColorsAndObjects.getRandomObject(butNot: nil)
            subjectString1 = miniGameStage.chosenObject!.objectType
            colorDescriptor1 = miniGameStage.chosenObject!.naturalColor!.name
            subjectColor = miniGameStage.chosenObject!.naturalColor!
            aOrAn = miniGameStage.chosenObject!.naturalColor!.aOrAn
            withOrThatSays = "with "
        }
        
        if miniGameStage.notHaveObjectColor {
            //this doesn't deal with multicolored objects yet
            miniGameStage.chosenObject = gameColorsAndObjects.getRandomObject(butNot: nil)
            subjectString1 = miniGameStage.chosenObject!.objectType
            colorDescriptor1 = miniGameStage.chosenObject!.naturalColor!.name
            subjectColor = miniGameStage.chosenObject!.naturalColor!
            aOrAn = miniGameStage.chosenObject!.naturalColor!.aOrAn
            withOrThatSays = "that does not have "
        }

        //assumes word has no color
        if miniGameStage.hasWord {
            miniGameStage.chosenWord = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            subjectString1 = miniGameStage.chosenWord!.name
            colorDescriptor1 = ""
            aOrAn = ""
            withOrThatSays = "that says "
        }
        
        if miniGameStage.notHaveWord {
            miniGameStage.chosenWord = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            subjectString1 = miniGameStage.chosenWord!.name
            colorDescriptor1 = ""
            subjectColor = miniGameStage.chosenWord!
            aOrAn = ""
            withOrThatSays = "that does not say "
        }
        
        if miniGameStage.hasFontColor {
            miniGameStage.chosenFontColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            subjectString1 = " font"
            colorDescriptor1 = miniGameStage.chosenFontColor!.name
            subjectColor = miniGameStage.chosenFontColor!
            aOrAn = ""
            withOrThatSays = "with "
        }
        
        if miniGameStage.notHaveFontColor {
            miniGameStage.chosenFontColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            subjectString1 = " font"
            colorDescriptor1 = miniGameStage.chosenFontColor!.name
            subjectColor = miniGameStage.chosenFontColor!
            aOrAn = ""
            withOrThatSays = "that does not have "
        }
        

        
        var beginning = NSAttributedString(string: "Tap square \(withOrThatSays)\(aOrAn)")
        var middle: NSAttributedString
        var end: NSAttributedString

        
        var justAColoredSquare = false
        //if its just a colored square
        if miniGameStage.hasBackground && !miniGameStage.fillerAddFontColors && !miniGameStage.fillerAddWords && !miniGameStage.fillerAddObjects {
            justAColoredSquare = true
            beginning = NSAttributedString(string: "Tap ")
        }

        var justAColoredSquareNot = false
        //if its just a colored square
        if miniGameStage.notHaveBackground && !miniGameStage.fillerAddFontColors && !miniGameStage.fillerAddWords && !miniGameStage.fillerAddObjects {
            justAColoredSquareNot = true
            beginning = NSAttributedString(string: "Tap square that is not ")
        }

        
       
        
        
        var tempGameColor: GameColor
     
        if miniGameStage.descriptionConfusingColor {
            tempGameColor = gameColorsAndObjects.getRandomGameColor(butNot: [subjectColor])
        } else {
            tempGameColor = GameColor.white
        }
        
        
        
        if justAColoredSquareNot {
            middle = NSAttributedString(string: colorDescriptor1, attributes: [NSForegroundColorAttributeName: tempGameColor.fontColor])
            end = NSAttributedString(string: "")
        } else if justAColoredSquare {
            middle = NSAttributedString(string: colorDescriptor1, attributes: [NSForegroundColorAttributeName: tempGameColor.fontColor])
            end = NSAttributedString(string: " square")
        } else if colorDescriptor1 != "" {
            middle = NSAttributedString(string: colorDescriptor1, attributes: [NSForegroundColorAttributeName: tempGameColor.fontColor])
            end = NSAttributedString(string: subjectString1)
        } else {
            middle = NSAttributedString(string: colorDescriptor1)
            end = NSAttributedString(string: subjectString1, attributes: [NSForegroundColorAttributeName: tempGameColor.fontColor])
        }
        


        
        let final = NSMutableAttributedString()
        
        final.append(beginning)
        final.append(middle)
        final.append(end)
  
        let myParagraphStyle = NSMutableParagraphStyle()
        myParagraphStyle.headIndent = 10
        myParagraphStyle.firstLineHeadIndent = 10
        myParagraphStyle.tailIndent = -10
        myParagraphStyle.alignment = .center
        //myParagraphStyle.lineBreakMode = .byWordWrapping
        
        final.addAttribute(NSParagraphStyleAttributeName, value: myParagraphStyle, range: NSRange(location: 0, length: final.length))
        
        self.instructions = final
    }
    

    
    private func updateSquares() {
        
        //update primary answer word/font/object
        updateAnswerWordFontOrObject()
        
        //update square objects if required
        if miniGameStage.hasObject || miniGameStage.notHaveObject || miniGameStage.hasObjectColor || miniGameStage.notHaveObjectColor || miniGameStage.fillerAddObjects && !objectUpdated {
            updateSquareObjects()
        }
        
        //update square words if required
        if miniGameStage.hasWord || miniGameStage.notHaveWord || miniGameStage.hasFontColor || miniGameStage.notHaveFontColor || miniGameStage.fillerAddWords && !wordUpdated{
            updateSquareWords()
        }
        
        //update square font color if required
        if miniGameStage.hasFontColor || miniGameStage.notHaveFontColor || miniGameStage.fillerAddFontColors && !fontColorUpdated{
            updateSquareFontColors()
        }
        
        //update square backgrounds
        if !backgroundUpdated {
            updateSquareBackgrounds()
        }
        
        
    }
    
    private func updateAnswerWordFontOrObject() {
        
        if miniGameStage.hasObject ||  miniGameStage.notHaveObject || miniGameStage.hasObjectColor || miniGameStage.notHaveObjectColor {
            updateSquareObjects()
        }
        
        if miniGameStage.hasWord || miniGameStage.notHaveWord  {
            updateSquareWords()
        }
        
        if miniGameStage.hasFontColor || miniGameStage.notHaveFontColor {
            updateSquareFontColors()
        }
        
        if miniGameStage.hasBackground || miniGameStage.notHaveBackground {
            updateSquareBackgrounds()
        }

    }
    
    
    private func updateSquareObjects() {
        
        objectUpdated = true
        //set object for right answer

        if miniGameStage.chosenObject != nil {
            squareCollection[answerIndex!].squareObject = miniGameStage.chosenObject!
        } else if miniGameStage.objectEqualsWord && wordUpdated {
            //make objects match the words that have already been set
            makeObjectsMatchWords()
            return
        } else if miniGameStage.objectEqualsBackground && backgroundUpdated {
            //make objects match the words that have already been set
            makeObjectsMatchBackground()
            return
        } else if miniGameStage.objectEqualsFontColor && fontColorUpdated {
            //make objects match the font colors that have already been set
            makeObjectsMatchFontColor()
            return
        } else {
            let randomObject = gameColorsAndObjects.getRandomObject(butNot: nil)
            squareCollection[answerIndex!].squareObject = randomObject
            miniGameStage.utilizedObjects.append(randomObject)
        }
        
        //set objects for other squares
        for index in 0..<squareCollection.count {
            if index != answerIndex! {
                let randomObject = gameColorsAndObjects.getRandomObject(butNot: miniGameStage.utilizedObjects)
                squareCollection[index].squareObject = randomObject
                miniGameStage.utilizedObjects.append(randomObject)
            }
        }
        
        
    }
    
    private func updateSquareWords() {
        
        wordUpdated = true
        
        //set word for right answer
        if miniGameStage.chosenWord != nil {
            squareCollection[answerIndex!].squareWord = miniGameStage.chosenWord
        } else if miniGameStage.objectEqualsWord && objectUpdated {
            //make objects match the words that have already been set
            makeWordsMatchObjects()
            return
        } else if miniGameStage.wordEqualsBackground && backgroundUpdated {
            //make objects match the backgrounds that have already been set
            makeWordsMatchBackground()
            return
        } else if miniGameStage.fontColorEqualsWord && fontColorUpdated {
            //make objects match the font colors that have already been set
            makeWordsMatchFontColors()
            return
        } else {
            let randomColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            squareCollection[answerIndex!].squareWord = randomColor
            miniGameStage.utilizedWords.append(randomColor)
        }
        
        //set words for other squares
        for index in 0..<squareCollection.count {
            if index != answerIndex! {
                let randomColor = gameColorsAndObjects.getRandomGameColor(butNot: miniGameStage.utilizedWords)
                squareCollection[index].squareWord = randomColor
                miniGameStage.utilizedWords.append(randomColor)
            }
        }
        
        
    }
    
    private func updateSquareFontColors() {
        
        fontColorUpdated = true
        
        //set font for right answer
        if miniGameStage.chosenFontColor != nil {
            squareCollection[answerIndex!].squareFontColor = miniGameStage.chosenFontColor
        } else if miniGameStage.fontColorEqualsWord && wordUpdated {
            //make font colors match the words that have already been set
            makeFontColorsMatchWords()
            return
        } else if miniGameStage.fontColorEqualsBackground && backgroundUpdated {
            //make font colors match the backgrounds that have already been set
            makeFontColorsMatchBackground()
            return
        } else if miniGameStage.objectEqualsFontColor && objectUpdated {
            //make font colors match the objects that have already been set
            makeFontColorsMatchObjects()
            return
        } else {
            let randomColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            squareCollection[answerIndex!].squareFontColor = randomColor
            miniGameStage.utilizedFontColors.append(randomColor)
        }
        
        //set font for other squares
        for index in 0..<squareCollection.count {
            if index != answerIndex! {
                let randomColor = gameColorsAndObjects.getRandomGameColor(butNot: miniGameStage.utilizedFontColors)
                squareCollection[index].squareFontColor = randomColor
                miniGameStage.utilizedFontColors.append(randomColor)
            }
        }
        
        
    }
    

    
    private func updateSquareBackgrounds() {
        
        backgroundUpdated = true
        
        //set background for right answer
        if miniGameStage.chosenBackgroundColor != nil {
            squareCollection[answerIndex!].squareBackgroundColor = miniGameStage.chosenBackgroundColor!
        } else if miniGameStage.wordEqualsBackground && wordUpdated {
            //make background match the words that have already been set
            makeBackgroundsMatchWordColors()
            return
        } else if miniGameStage.objectEqualsBackground && objectUpdated {
            //make background match the objects that have already been set
            makeBackgroundsMatchObjectNaturalColors()
            return
        } else if miniGameStage.fontColorEqualsBackground && fontColorUpdated {
            //make background match the font colors that have already been set
            makeBackgroundsMatchFontColors()
            return
        } else {
            let randomColor = gameColorsAndObjects.getRandomGameColor(butNot: nil)
            squareCollection[answerIndex!].squareBackgroundColor = randomColor
            miniGameStage.utilizedBackgroundColors.append(randomColor)
        }
        
        //set other squares
        for index in 0..<squareCollection.count {
            if index != answerIndex! {
                let tempNamedUIColor = gameColorsAndObjects.getRandomGameColor(butNot: miniGameStage.utilizedBackgroundColors)
                squareCollection[index].squareBackgroundColor = tempNamedUIColor
                miniGameStage.utilizedBackgroundColors.append(tempNamedUIColor)
            }
        }
        
        
    }
    
    private func makeBackgroundsMatchObjectNaturalColors() {
        //set square backgrounds equal to object's natural colors
        for index in 0..<squareCollection.count {
            squareCollection[index].squareBackgroundColor = squareCollection[index].squareObject!.naturalColor!
        }
    }
    
    private func makeBackgroundsMatchWordColors() {
        //set square backgrounds equal to word color
        for index in 0..<squareCollection.count {
            squareCollection[index].squareBackgroundColor = squareCollection[index].squareWord!
        }
    }
    
    private func makeBackgroundsMatchFontColors() {
        //set square backgrounds equal to font color
        for index in 0..<squareCollection.count {
            squareCollection[index].squareBackgroundColor = squareCollection[index].squareFontColor!
        }
    }
    
    private func makeWordsMatchFontColors() {
        //set square words equal to font color
        for index in 0..<squareCollection.count {
            squareCollection[index].squareWord = squareCollection[index].squareFontColor!
        }
    }
    
    private func makeWordsMatchObjects() {
        //set square words equal to Object natural color
        for index in 0..<squareCollection.count {
            squareCollection[index].squareWord = squareCollection[index].squareObject!.naturalColor
        }
    }
    
    private func makeWordsMatchBackground() {
        //set square words equal to background
        for index in 0..<squareCollection.count {
            squareCollection[index].squareWord = squareCollection[index].squareBackgroundColor
        }
    }
    
    private func makeFontColorsMatchWords() {
        //set square font colors equal to words
        for index in 0..<squareCollection.count {
            squareCollection[index].squareFontColor = squareCollection[index].squareWord!
        }
    }
    
    private func makeFontColorsMatchBackground() {
        //set square font colors equal to words
        for index in 0..<squareCollection.count {
            squareCollection[index].squareFontColor = squareCollection[index].squareBackgroundColor
        }
    }
    
    private func makeFontColorsMatchObjects() {
        //set square font colors equal to words
        for index in 0..<squareCollection.count {
            squareCollection[index].squareFontColor = squareCollection[index].squareObject!.naturalColor!
        }
    }
    
    private func makeObjectsMatchWords() {
        //set square object colors equal to words
        for index in 0..<squareCollection.count {
            squareCollection[index].squareObject = squareCollection[index].squareWord!.getAssociatedObject()
        }
    }
    
    private func makeObjectsMatchBackground() {
        //set square objects equal to backgrounds
        for index in 0..<squareCollection.count {
            squareCollection[index].squareObject = squareCollection[index].squareBackgroundColor.getAssociatedObject()
        }
    }
    
    private func makeObjectsMatchFontColor() {
        //set square objects equal to backgrounds
        for index in 0..<squareCollection.count {
            squareCollection[index].squareObject = squareCollection[index].squareFontColor!.getAssociatedObject()
        }
    }
}


//        //Add text
//        let textRect = CGRect(x: 0, y: 0, width: squareSideSize, height: squareSideSize/2)
//        let text = "yellow"
//        let font = UIFont(name: "Arial", size: 20)
//        let myTextColor = UIColor.red
//        let textStyle = NSMutableParagraphStyle()
//        textStyle.alignment = .center
//
//        let textAttributes = [
//            NSFontAttributeName: font!,
//            NSForegroundColorAttributeName: myTextColor,
//            NSParagraphStyleAttributeName: textStyle
//            ] as [String : Any]
//        text.draw(in: textRect, withAttributes: textAttributes)


//    private func setupMiniGame(miniGameStage: MiniGameStage) {
//
//        var utilizedColor = [NamedUIColor]()
//
//        //sets instructions
//        instructions = miniGameDescription.descriptionText!
//
//        //set right answer
//        let rightAnswerIndex = Int(arc4random_uniform(UInt32(squareCollection.count)))
//        var tempNamedUIColor = miniGameDescription.hasBackgroundColors.popLast()
//        squareCollection[rightAnswerIndex].squareBackgroundColor = tempNamedUIColor!
//        squareCollection[rightAnswerIndex].rightAnswer = true
//        utilizedColor.append(tempNamedUIColor!)
//
//
//        //set other squares
//        for index in 0..<squareCollection.count {
//            if index != rightAnswerIndex {
//                tempNamedUIColor = gameColors.getRandomNamedUIColor(butNot: utilizedColor)
//                squareCollection[index].squareBackgroundColor = tempNamedUIColor!
//                squareCollection[index].rightAnswer = false
//                utilizedColor.append(tempNamedUIColor!)
//            }
//        }
//
//
//
//    }

//    private func newMinigameStage(gameSession: GameSession) -> MiniGameStage {
//
//        var promotionModulo: Int
//        var maxStage: Int
//        var stageRange: Int
//        var stagePromotionJump: Int
//
//        switch gameSession.currentDifficulty! {
//        case GameSession.Difficulty.easy:
//            promotionModulo = GamePlayParameters.Stages.easyNumLevelsUntilStagePromotion
//            maxStage = GamePlayParameters.Stages.easyMaxStage
//            stageRange = GamePlayParameters.Stages.easyStageRange
//            stagePromotionJump = GamePlayParameters.Stages.easyStagePromotionCount
//        case GameSession.Difficulty.medium:
//            promotionModulo = GamePlayParameters.Stages.mediumNumLevelsUntilStagePromotion
//            maxStage = GamePlayParameters.Stages.mediumMaxStage
//            stageRange = GamePlayParameters.Stages.mediumStageRange
//            stagePromotionJump = GamePlayParameters.Stages.mediumStagePromotionCount
//        case GameSession.Difficulty.hard:
//            promotionModulo = GamePlayParameters.Stages.hardNumLevelsUntilStagePromotion
//            maxStage = GamePlayParameters.Stages.hardMaxStage
//            stageRange = GamePlayParameters.Stages.hardStageRange
//            stagePromotionJump = GamePlayParameters.Stages.hardStagePromotionCount
//        }
//
//        //Unlock another stage if exactly divisible by promotionModulo and not above max stage
//        if gameSession.getCurrentLevel() % promotionModulo == 0 && gameSession.stageUnlocked < maxStage{
//            gameSession.stageUnlocked += stagePromotionJump
//            if gameSession.stageUnlocked > maxStage {
//                gameSession.stageUnlocked = maxStage
//            }
//        }
//
//        if stageRange > gameSession.stageUnlocked {
//            stageRange = gameSession.stageUnlocked
//        }
//
//        let randomStageSubtractor = Int(arc4random_uniform(UInt32(stageRange)))
//        let computedStage = gameSession.stageUnlocked - randomStageSubtractor
//
//        print("stage unlocked: \(gameSession.stageUnlocked)")
//        print("current level: \(gameSession.getCurrentLevel())")
//        print("max stage: \(stageRange)")
//        print("stage range: \(stageRange)")
//        print("random subtractor: \(randomStageSubtractor)")
//        print("computed stage: \(computedStage)")
//
//        // FIXME: for debugging stages
//        //return MiniGameStage(stage: 20)
//        return MiniGameStage(stage: computedStage)
//    }
