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

class PupperSplashViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var reactionImage: UIImageView!
    
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
        
        reactionImage.image = UIImage(named: getHappyDogPhotoName())
        //provide first way to move on from Reaction Image view by timer
        moveOnTimer = Timer.scheduledTimer(timeInterval: TimeInterval(viewingTime), target: self, selector: #selector(nextStage), userInfo: nil, repeats: false)

        
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
        self.present(nextViewController, animated: true, completion: nil)
        
    }
   
    private func getHappyDogPhotoName() -> String {
        var returnString = "happydog"
        returnString += String(arc4random_uniform(9))
        return returnString
    }


}
