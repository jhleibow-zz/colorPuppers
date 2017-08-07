//
//  MiniGameStage.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/12/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import Foundation


class MiniGameStage {
    
    //MARK: - Properties
    
    //These boolean vars define a minigame and its correct answer:
    var hasBackground = false
    var notHaveBackground = false
    var hasWord = false
    var notHaveWord = false
    var hasFontColor = false
    var notHaveFontColor = false
    var hasObject = false
    var notHaveObject = false
    var hasObjectColor = false
    var notHaveObjectColor = false
    
    var wordEqualsBackground = false
    var objectEqualsBackground = false
    var fontColorEqualsBackground = false
    var objectEqualsWord = false
    var objectEqualsFontColor = false
    var fontColorEqualsWord = false
    
    var descriptionConfusingColor = false
    
    var fillerAddObjects = false
    var fillerAddObjectColors = false
    var fillerAddWords = false
    var fillerAddFontColors = false
    
    //var relationships = ObjectRelationships.allSame
    
    var usesNumberOfFillerSlots = 0
    
    //these vars store chosen colors (and object) if they exist
    var chosenBackgroundColor: GameColor? {
        didSet {
            if chosenBackgroundColor != nil {
                utilizedBackgroundColors.append(chosenBackgroundColor!)
            }
        }
    }
    var chosenObjectColor: GameColor? {
        didSet {
            if chosenObjectColor != nil {
                utilizedObjectColors.append(chosenObjectColor!)
            }
            
        }
    }
    var chosenWord: GameColor? {
        didSet {
            if chosenWord != nil {
                utilizedWords.append(chosenWord!)
            }
        }
    }
    var chosenFontColor: GameColor? {
        didSet {
            if chosenFontColor != nil {
                utilizedFontColors.append(chosenFontColor!)
            }
        }
    }
    var chosenObject: GameObject?{
        didSet {
            if chosenObject != nil {
                utilizedObjects.append(chosenObject!)
            }
        }
    }
    
    //these vars keep track of which colors have already been used
    var utilizedBackgroundColors = [GameColor]()
    var utilizedWords = [GameColor]()
    var utilizedObjectColors = [GameColor]()
    var utilizedFontColors = [GameColor]()
    var utilizedObjects = [GameObject]()
    
    
    
    //MARK: - Initialization
    
    init (gameSession: GameSession) {
        updateStage(gameSession: gameSession)
    }
    
    init () {

    }

    
    //MARK: - Public Methods
    
    func updateStage(gameSession: GameSession) {
        
        //reset properties to false
        resetAllProperties()
        
        //sets the stage type
        setStageType(gameSession: gameSession)
        
        //Sets the fillers
        setFillers(gameSession: gameSession)
        
        //Sets the relationship constraints
        setRelationshipConstraints(gameSession: gameSession)
        
        //set the instuctions confusing color to be off or on
        setInstructionsConfusingColor(gameSession: gameSession)
    }
    
    
    
    //MARK: - Private Methods
    
    private func resetAllProperties() {
        self.hasBackground = false
        self.notHaveBackground = false
        self.hasWord = false
        self.notHaveWord = false
        self.hasFontColor = false
        self.notHaveFontColor = false
        self.hasObject = false
        self.notHaveObject = false
        self.hasObjectColor = false
        self.notHaveObjectColor = false
        
        self.descriptionConfusingColor = false

        self.wordEqualsBackground = false
        self.objectEqualsBackground = false
        self.fontColorEqualsBackground = false
        self.objectEqualsWord = false
        self.objectEqualsFontColor = false
        self.fontColorEqualsWord = false
        
        self.fillerAddObjects = false
        self.fillerAddObjectColors = false
        self.fillerAddWords = false
        self.fillerAddFontColors = false
        
        //relationships = ObjectRelationships.allSame
        
        chosenBackgroundColor = nil
        chosenObjectColor = nil
        chosenWord = nil
        chosenFontColor = nil
        chosenObject = nil
       
        utilizedBackgroundColors.removeAll()
        utilizedWords.removeAll()
        utilizedObjectColors.removeAll()
        utilizedFontColors.removeAll()
        utilizedObjects.removeAll()
        
        usesNumberOfFillerSlots = 0
    }
    
    private func setStageType(gameSession: GameSession) {

        let stageType = Utilities.getDistributedRandomIndex(upperBoundInclusive: gameSession.stageTypeUnlocked, distributionIndex: gameSession.distributionUnlocked)
        
        switch stageType {
            
        case 0:
            hasBackground = true
            usesNumberOfFillerSlots = 0
        case 1:
            hasObject = true
            usesNumberOfFillerSlots = 1
        case 2:
            hasWord = true
            usesNumberOfFillerSlots = 1
        case 3:
            hasObjectColor = true
            usesNumberOfFillerSlots = 1
        case 4:
            notHaveBackground = true
            usesNumberOfFillerSlots = 0
        case 5:
            notHaveObject = true
            usesNumberOfFillerSlots = 1
        case 6:
            notHaveWord = true
            usesNumberOfFillerSlots = 1
        case 7:
            notHaveObjectColor = true
            usesNumberOfFillerSlots = 1
        case 8:
            notHaveFontColor = true
            usesNumberOfFillerSlots = 2
        case 9:
            hasFontColor = true
            usesNumberOfFillerSlots = 2
        default:
            usesNumberOfFillerSlots = 0
        }
    }
    
    private func setFillers(gameSession: GameSession) {
        
        let fillSlotsLeft = GamePlayParameters.StageGeneration.totalNumberOfFillers - usesNumberOfFillerSlots
        
        var upperFillerBound: Int
        
        if gameSession.fillerUnlocked > fillSlotsLeft {
            upperFillerBound = fillSlotsLeft
        } else {
            upperFillerBound = gameSession.fillerUnlocked
        }
        
        var fillerNum = Utilities.getDistributedRandomIndex(upperBoundInclusive: upperFillerBound, distributionIndex: gameSession.distributionUnlocked)
        
        
        //background only case
        if fillerNum > 0 && (hasBackground || notHaveBackground) {
            fillerAddObjects = true
            fillerNum -= 1
        }
        
        //has objects case (and filler with objects case)
        if fillerNum > 0 && (hasObject || notHaveObject || hasObjectColor || notHaveObjectColor || fillerAddObjects) {
            fillerAddWords = true
            fillerNum -= 1
        }
        
        //has words case (and filler with words case)
        if fillerNum > 0 && (hasWord || notHaveWord || fillerAddWords) {
            fillerAddFontColors = true
            fillerNum -= 1
        }
        
        //has font color case
        if fillerNum > 0 && (hasFontColor || notHaveFontColor) {
            fillerAddObjects = true
            fillerNum -= 1
        }
    }
    
    private func setRelationshipConstraints(gameSession: GameSession) {
        let relationshipIndex = Utilities.getDistributedRandomIndex(upperBoundInclusive: gameSession.relationshipUnlocked, distributionIndex: gameSession.distributionUnlocked)
        
        
        switch relationshipIndex {
            
        case 0:
            //relationships = ObjectRelationships.allSame
            setAllRelationshipsTrue()
        case 1:
            //relationships = ObjectRelationships.secondaryDifferent
            if (hasBackground || notHaveBackground) {
                setBackgroundTrue()
            } else if (hasObject || notHaveObject || hasObjectColor || notHaveObjectColor) {
                setObjectTrue()
            } else if (hasWord || notHaveWord) {
                setWordTrue()
            } else if (hasFontColor || notHaveFontColor) {
                setFontColorTrue()
            }
        case 2:
            //relationships = ObjectRelationships.allDifferent
            break
        case 3:
            //relationships = ObjectRelationships.primaryDifferent
            setAllRelationshipsTrue()
            if (hasBackground || notHaveBackground) {
                setBackgroundFalse()
            } else if (hasObject || notHaveObject || hasObjectColor || notHaveObjectColor) {
                setObjectFalse()
            } else if (hasWord || notHaveWord) {
                setWordFalse()
            } else if (hasFontColor || notHaveFontColor) {
                setFontColorFalse()
            }
        default:
            //relationships = ObjectRelationships.allSame
            setAllRelationshipsTrue()
        }
    }
    
    private func setInstructionsConfusingColor(gameSession: GameSession) {
        let confusingColorIndex = Utilities.getDistributedRandomIndex(upperBoundInclusive: 1, distributionIndex: gameSession.distributionUnlocked)
        
        if confusingColorIndex == 1 && gameSession.currentDifficulty == GameSession.Difficulty.hard {
            descriptionConfusingColor = true
        }
    }
    
    private func setAllRelationshipsTrue() {
        wordEqualsBackground = true
        objectEqualsBackground = true
        fontColorEqualsBackground = true
        objectEqualsWord = true
        objectEqualsFontColor = true
        fontColorEqualsWord = true
    }
    
    private func setFontColorFalse() {
        fontColorEqualsBackground = false
        objectEqualsFontColor = false
        fontColorEqualsWord = false
    }
    
    private func setWordFalse() {
        wordEqualsBackground = false
        objectEqualsWord = false
        fontColorEqualsWord = false
    }
    
    private func setObjectFalse() {
        objectEqualsWord = false
        objectEqualsFontColor = false
        objectEqualsBackground = false
    }
    
    private func setBackgroundFalse() {
        wordEqualsBackground = false
        objectEqualsBackground = false
        fontColorEqualsBackground = false
    }
    
    private func setFontColorTrue() {
        fontColorEqualsBackground = true
        objectEqualsFontColor = true
        fontColorEqualsWord = true
    }
    
    private func setWordTrue() {
        wordEqualsBackground = true
        objectEqualsWord = true
        fontColorEqualsWord = true
    }
    
    private func setObjectTrue() {
        objectEqualsWord = true
        objectEqualsFontColor = true
        objectEqualsBackground = true
    }
    
    private func setBackgroundTrue() {
        wordEqualsBackground = true
        objectEqualsBackground = true
        fontColorEqualsBackground = true
    }
    
}

// old stuff probably never use
//        var descriptionText: NSAttributedString?
//
//        var hasBackgroundColors = [NamedUIColor]()
//        var doesNotHaveBackgroundColors = [NamedUIColor]()
//
//        var hasWords = [String]()
//        var doesNotHaveWords = [String]()
//
//        var hasObjects = [String]()
//        var doesNotHaveObjects = [String]()
//
//        var hasWordColors = [NamedUIColor]()
//        var doesNotHaveWordColors = [NamedUIColor]()
//
//        var hasObjectColors = [NamedUIColor]()
//        var doesNotHaveObjectColors = [NamedUIColor]()
//
//self.hasBackground = hasBackground
//self.notHaveBackground = notHaveBackground
//self.hasWord = hasWord
//self.notHaveWord = notHaveWord
//self.hasFontColor = hasFontColor
//self.notHaveFontColor = notHaveFontColor
//self.hasObject = hasObject
//self.notHaveObject = notHaveObject
//self.hasObjectColor = hasObjectColor
//self.notHaveObjectColor = notHaveObjectColor
//
//self.wordEqualsBackground = wordEqualsBackground
//self.objectColorEqualsBackground = objectColorEqualsBackground
//self.fontColorEqualsWord = fontColorEqualsWord
//self.descriptionConfusingColor = descriptionConfusingColor
//
//self.fillerAddObjects = fillerAddObjects
//self.fillerAddObjectColors = fillerAddObjectColors
//self.fillerAddWords = fillerAddWords
//self.fillerAddFontColors = fillerAddFontColors

//func updateStage(stage: Int) {
//    
//    //reset properties to false
//    resetAllProperties()
//    
//    
//    switch stage {
//        
//    case 1:
//        self.hasBackground = true
//        
//    case 2:
//        self.hasObject = true
//        self.objectEqualsBackground = true
//        self.fillerAddObjects = true
//        
//    case 3:
//        self.hasWord = true
//        self.wordEqualsBackground = true
//        self.fillerAddWords = true
//        
//    case 4:
//        self.notHaveBackground = true
//        
//    case 5:
//        self.notHaveObject = true
//        self.objectEqualsBackground = true
//        self.fillerAddObjects = true
//        
//    case 6:
//        self.hasWord = true
//        self.fontColorEqualsWord = true
//        self.wordEqualsBackground = true
//        self.fillerAddWords = true
//        self.fillerAddFontColors = true
//        
//    case 7:
//        self.hasObjectColor = true
//        self.objectEqualsBackground = true
//        self.fillerAddObjects = true
//        self.fillerAddObjectColors = true
//        
//    case 8:
//        self.hasObjectColor = true
//        self.fillerAddObjects = true
//        self.fillerAddObjectColors = true
//        
//    case 9:
//        self.notHaveWord = true
//        self.wordEqualsBackground = true
//        self.fillerAddWords = true
//        
//    case 10:
//        self.hasFontColor = true
//        self.fontColorEqualsWord = true
//        self.fillerAddFontColors = true
//        self.fillerAddWords = true
//        
//    case 11:
//        self.notHaveFontColor = true
//        self.fontColorEqualsWord = true
//        self.fillerAddFontColors = true
//        self.fillerAddWords = true
//        
//    case 12:
//        self.notHaveFontColor = true
//        self.fillerAddFontColors = true
//        self.fillerAddWords = true
//        
//    case 13:
//        self.hasWord = true
//        self.fillerAddFontColors = true
//        self.fillerAddWords = true
//        
//    case 14:
//        self.hasWord = true
//        self.fontColorEqualsWord = true
//        self.fillerAddWords = true
//        self.fillerAddFontColors = true
//        
//    case 15:
//        self.hasWord = true
//        self.fillerAddWords = true
//        
//    case 16:
//        self.notHaveObjectColor = true
//        self.objectEqualsBackground = true
//        self.fillerAddObjects = true
//        self.fillerAddObjectColors = true
//        
//    case 17:
//        self.notHaveObjectColor = true
//        self.fillerAddObjects = true
//        self.fillerAddObjectColors = true
//        
//    case 18:
//        self.hasFontColor = true
//        self.fillerAddWords = true
//        self.fillerAddFontColors = true
//        
//    case 19:
//        self.hasFontColor = true
//        self.wordEqualsBackground = true
//        self.fillerAddWords = true
//        self.fillerAddFontColors = true
//        
//    case 20:
//        self.notHaveWord = true
//        self.fillerAddWords = true
//        
//    default:
//        break
//    }
//    
//}

//    enum StageType {
//        case hasBackground
//        case hasObject
//        case hasWord
//        case hasObjectColor
//        case doesNotHaveBackground
//        case doesNotHaveObject
//        case doesNotHaveWord
//        case hasFontColor
//        case doesNotHaveObjectColor
//        case doesNotHaveFontColor
//    }
//
//    enum Fillers {
//        case zero
//        case one
//        case two
//        case three
//    }
//
//    enum ObjectRelationships {
//        case allSame
//        case secondaryDifferent
//        case allDifferent
//        case primaryDifferent
//    }
