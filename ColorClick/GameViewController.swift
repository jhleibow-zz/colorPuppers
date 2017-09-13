//
//  GameViewController.swift
//  ColorClick
//
//  Created by John Leibowitz on 5/29/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIViewControllerTransitioningDelegate {

    
    //MARK: - Properties
    
    //IMPORTANT NOTE: square button tag numbers must start at 0 and be in consecutive order without skipping values in interface builder
    @IBOutlet weak var topLeftSquareButton: SquareButton!
    @IBOutlet weak var topRightSquareButton: SquareButton!
    @IBOutlet weak var bottomLeftSquareButton: SquareButton!
    @IBOutlet weak var bottomRightSquareButton: SquareButton!
    var squareButtonArray = [SquareButton]()
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timeLeftProgressBar: UIProgressView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    
    //how many increments the progress bar has
    let numberOfProgressBarUpdates = GamePlayParameters.GameView.statusBarIncrements
    
    //current progress bar status
    var countOfProgressBarUpdates = 0
    
    //timer for progress bar
    var miniGameTimer = Timer()
    
    //user made the right choice: tapped a correct square, or no tap if no right answers
    var correct: Bool?
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    //MARK: - Actions
    @IBAction func touchSquare(_ sender: SquareButton) {
        
        // FIXME: should this be calling a gamesession function that handles right or wrong answer
        
        //timer no longer needed
        miniGameTimer.invalidate()
        
        
        let tapIndex = sender.tag
        
        //checks if tapped square was correct answer
        if gameSession.miniGame.squareCollection[tapIndex].rightAnswer {
            correctAnswer()
        } else {
            incorrectAnswer()
        }
        
        transitionToNextView()
    }
    
    
    //MARK: - View Controller Events
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets board up for new minigame
        resetMinigame()
    }
    
    

    
    
    //MARK: - Private Methods

    private func resetMinigame() {
        //loads all squares into array
        loadSquareButtonArray()
        
        //updates model (minigame)
        gameSession.miniGame.updateMiniGame(gameSession: gameSession)
        
        //Update squares in view to match model (squares belonging to minigame)
        for index in 0..<squareButtonArray.count {
            squareButtonArray[index].setupButton(squareBackgroundColor: gameSession.miniGame.squareCollection[index].squareBackgroundColor, gameObject: gameSession.miniGame.squareCollection[index].squareObject, gameWord: gameSession.miniGame.squareCollection[index].squareWord, gameFontColor: gameSession.miniGame.squareCollection[index].squareFontColor)
        }
        
        //Update instructions to match model and update font size
        
        instructionLabel.numberOfLines = 0
//        instructionLabel.minimumScaleFactor = 0.1
//        instructionLabel.adjustsFontSizeToFitWidth = true
        
        let labelHeight = instructionLabel.frame.height - UIScreen.main.bounds.height/15 //margin
        let labelWidth = instructionLabel.frame.width
        var fontSize = instructionLabel.frame.width/CGFloat(GamePlayParameters.Fonts.instructionsLabelWidthRatioToFontSize)
        var currentSizeBox: CGRect
        
        repeat {
            let gameFont = UIFont(name: GamePlayParameters.Fonts.gameFontName, size: fontSize)
            gameSession.miniGame.instructions!.addAttribute(NSFontAttributeName, value: gameFont!, range: NSRange(location: 0, length: gameSession.miniGame.instructions!.length))
            let constrainedWidth = CGSize(width: labelWidth * (1 - GamePlayParameters.Margins.marginRatioToSide), height: CGFloat.greatestFiniteMagnitude)
            currentSizeBox = gameSession.miniGame.instructions!.boundingRect(with: constrainedWidth, options: .usesLineFragmentOrigin, context: nil)
            fontSize -= 2.0
        } while (currentSizeBox.height > labelHeight && fontSize > 0)
        
        instructionLabel.attributedText = gameSession.miniGame.instructions
        
        //Start Timer
        startGameTimer()
        
        //Label text to display current level
        currentLevelLabel.text = "Level \(gameSession.getCurrentLevel())"
    }
    
    //user chose correct answer
    private func correctAnswer() {
        print("you chose the right answer!")
        correct = true
        gameSession.minigamePassed()
    }

    
    //user chose incorrect answer
    private func incorrectAnswer() {
        print("you chose the wrong answer!")
        correct = false
        gameSession.miniGameFailed()
    }
    
    
    //loads all square buttons into an array
    private func loadSquareButtonArray() {
        squareButtonArray.append(contentsOf: [topLeftSquareButton, topRightSquareButton, bottomLeftSquareButton, bottomRightSquareButton])
    }
    
    
    //starts timer for minigame
    private func startGameTimer() {
        countOfProgressBarUpdates = 0
        timeLeftProgressBar.setProgress(Float(countOfProgressBarUpdates)/Float(numberOfProgressBarUpdates), animated: true)
        miniGameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(gameSession.miniGame.timeToSolve!/Float(numberOfProgressBarUpdates)), target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    //this function is run everytime the progress bar is incremented
    @objc private func timerFired() {
        
        if UIApplication.shared.applicationState == UIApplicationState.active {
        
            countOfProgressBarUpdates += 1
            timeLeftProgressBar.setProgress(Float(countOfProgressBarUpdates)/Float(numberOfProgressBarUpdates), animated: true)
            if countOfProgressBarUpdates == numberOfProgressBarUpdates {
                miniGameTimer.invalidate()
                timerRanOut()
            }
        }
        
    }
    
    //this function is run when timer runs out
    private func timerRanOut() {
        
        //this code block sets correctTap depending on if there was a correct answer available
        var gameHasCorrectAnswer = false
        for square in gameSession!.miniGame.squareCollection {
            if square.rightAnswer {
                gameHasCorrectAnswer = true
                break
            }
        }
        
        if gameHasCorrectAnswer {
            incorrectAnswer()
        } else {
            correctAnswer()
        }
        
        transitionToNextView()
    }
    
    //transitions to reaction view controller
    private func transitionToNextView() {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if correct! {
            let reactionViewController: PupperSplashViewController = myStoryBoard.instantiateViewController(withIdentifier: "PupperSplashViewControllerID") as! PupperSplashViewController
            reactionViewController.gameSession = gameSession
            reactionViewController.transitioningDelegate = self;
            self.present(reactionViewController, animated: true, completion: nil)
        } else {
            let reactionViewController: GameOverViewController = myStoryBoard.instantiateViewController(withIdentifier: "GameOverViewControllerID") as! GameOverViewController
            reactionViewController.gameSession = gameSession
            reactionViewController.transitioningDelegate = self;
            self.present(reactionViewController, animated: true, completion: nil)
        }
        

        

    }
    
    //MARK: - UIViewControllerTransitioningDelegate methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return gameSession
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    



}


// don't think gonna use this one
//    private func prepareButtons() {
//
//        //Update background color of SquareButtons
//        topLeftSquareButton.backgroundColor = miniGame.topLeftSquare.squareBackgroundColor
//        topRightSquareButton.backgroundColor = miniGame.topRightSquare.squareBackgroundColor
//        bottomLeftSquareButton.backgroundColor = miniGame.bottomLeftSquare.squareBackgroundColor
//        bottomRightSquareButton.backgroundColor = miniGame.bottomRightSquare.squareBackgroundColor
//
//        //Update title text of SquareButtons
//        topLeftSquareButton.setTitle(miniGame.topLeftSquare.squareText, for: .normal)
//        topRightSquareButton.setTitle(miniGame.topRightSquare.squareText, for: .normal)
//        bottomLeftSquareButton.setTitle(miniGame.bottomLeftSquare.squareText, for: .normal)
//        bottomRightSquareButton.setTitle(miniGame.bottomRightSquare.squareText, for: .normal)
//
//        //Update title text color of SquareButtons
//        topLeftSquareButton.setTitleColor(miniGame.topLeftSquare.squareFontColor, for: .normal)
//        topRightSquareButton.setTitleColor(miniGame.topRightSquare.squareFontColor, for: .normal)
//        bottomLeftSquareButton.setTitleColor(miniGame.bottomLeftSquare.squareFontColor, for: .normal)
//        bottomRightSquareButton.setTitleColor(miniGame.bottomRightSquare.squareFontColor, for: .normal)
//
//        //Set object images of SquareButtons
//        //topLeftSquareButton.setImage(UIImage(named: "yellowBanana"), for: .normal)
//    }


