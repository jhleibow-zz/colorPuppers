//
//  PupperSplashViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 8/1/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit
import AVFoundation

//TODO: add high score congrats

class PupperSplashViewController: UIViewController, UIViewControllerTransitioningDelegate {

    //MARK: - Properties
    
    @IBOutlet weak var reactionImage: UIImageView!
    @IBOutlet weak var congratsImage: UIImageView!
    
    //audio player
    var audioPlayer: AVAudioPlayer!
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
   
    //how long should the popup last
    let viewingTime = GamePlayParameters.ReactionScreenTimeout.timeoutValue
    
    var moveOnTimer = Timer()
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctAnswer()
        
    }
    
    
    //MARK: - Private Methods
    private func correctAnswer() {
        
        let barkPath = Bundle.main.path(forResource: "Bark", ofType: "m4a")
        let barkUrl = URL.init(fileURLWithPath: barkPath!)

        do {
            try audioPlayer = AVAudioPlayer(contentsOf: barkUrl)
        } catch {
            print ("audio file not found")
        }
        
        
        if shouldShowTrophyCongrats() {
            reactionImage.image = UIImage(named: "TrophyBackground")
            congratsImage.alpha = 1.0
            congratsImage.image = UIImage(named: "NewTrophy")
            //provide first way to move on from Reaction Image view by timer
            moveOnTimer = Timer.scheduledTimer(timeInterval: TimeInterval(viewingTime * 4), target: self, selector: #selector(nextStage), userInfo: nil, repeats: false)
        } else if shouldShowHighScoreCongrats() {
            reactionImage.image = UIImage(named: "HighScoreBackground")
            congratsImage.alpha = 1.0
            congratsImage.image = UIImage(named: "NewHighScore")
            //provide first way to move on from Reaction Image view by timer
            moveOnTimer = Timer.scheduledTimer(timeInterval: TimeInterval(viewingTime * 4), target: self, selector: #selector(nextStage), userInfo: nil, repeats: false)
        } else {
            reactionImage.image = UIImage(named: Utilities.getHappyDogPhotoName())
            congratsImage.alpha = 0.0
            //provide first way to move on from Reaction Image view by timer
            moveOnTimer = Timer.scheduledTimer(timeInterval: TimeInterval(viewingTime), target: self, selector: #selector(nextStage), userInfo: nil, repeats: false)
        }
        


        
        if gameSession.highScoresAndSettings!.soundOn  {
            audioPlayer.play()
        }
        
        //provide second way to move on from Reaction Image view by tap
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(nextStage))
        reactionImage.addGestureRecognizer(imageTap)
    }
    
    
    
    //go to start page or next game view depending on if player choose correctly
    @objc private func nextStage() {
        
        moveOnTimer.invalidate()
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var passToViewController: String
        
        passToViewController = "gameViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameViewController
        nextViewController.gameSession = gameSession
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
        
    }
   


    private func shouldShowTrophyCongrats() -> Bool {
        
        let passedLevel = gameSession.getCurrentLevel() - 1
        
        if passedLevel == 0 || passedLevel % GamePlayParameters.Badges.increment != 0 || passedLevel > GamePlayParameters.Badges.level4 {
            return false
        }
        
        switch gameSession.currentDifficulty! {
            
        case GameSession.Difficulty.easy:
            if gameSession.highScoresAndSettings!.easyHighScore < passedLevel {
                return true
            }
            
        case GameSession.Difficulty.medium:
            if gameSession.highScoresAndSettings!.mediumHighScore < passedLevel {
                return true
            }
        case GameSession.Difficulty.hard:
            if gameSession.highScoresAndSettings!.hardHighScore < passedLevel {
                return true
            }
        }
        
        return false
    }
    
    private func shouldShowHighScoreCongrats() -> Bool {
        
        if gameSession.highScoreCongratulationsShown {
            return false
        }
        
        let passedLevel = gameSession.getCurrentLevel() - 1
        
        if passedLevel == 0 {
            return false
        }
        
        switch gameSession.currentDifficulty! {
            
        case GameSession.Difficulty.easy:
            if gameSession.highScoresAndSettings!.easyHighScore < passedLevel {
                gameSession.highScoreCongratulationsShown = true
                return true
            }
            
        case GameSession.Difficulty.medium:
            if gameSession.highScoresAndSettings!.mediumHighScore < passedLevel {
                gameSession.highScoreCongratulationsShown = true
                return true
            }
        case GameSession.Difficulty.hard:
            if gameSession.highScoresAndSettings!.hardHighScore < passedLevel {
                gameSession.highScoreCongratulationsShown = true
                return true
            }
        }
        
        return false
    }
    
    //MARK: - UIViewControllerTransitioningDelegate methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return gameSession
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    

}
