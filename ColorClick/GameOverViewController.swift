//
//  GameOverViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/5/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import GoogleMobileAds
import UIKit
import AVFoundation

class GameOverViewController: UIViewController, GameSessionDelegate {

 
    //MARK: - Properties
    
    @IBOutlet weak var reactionImage: UIImageView!
    @IBOutlet weak var playAdButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var gameOverFrame: UIView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    //audio player
    var audioPlayer: AVAudioPlayer!
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!

  
   
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    
    //MARK: - Actions
    @IBAction func playAd(_ sender: UIButton) {
        if gameSession.rewardVideo?.isReady == true {
            gameSession.rewardVideo?.present(fromRootViewController: self)
        } else {
            print("video not available or read")
        }
    }
    
    @IBAction func noThanksButtonTap(_ sender: UIButton) {
        goBack()
    }
    
  
    @IBAction func continueButtonTap(_ sender: UIButton) {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var passToViewController: String
        
        passToViewController = "gameViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameViewController
        nextViewController.gameSession = gameSession
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        gameSession.delegate = self
        
        self.gameOverFrame.alpha = 0.0
        continueButton.alpha = 0.0
        roundCorners()
        wrongAnswer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInGameOverWindow()
    }

    
    //MARK: - GameSessionDelegate Methods
    func adWasWatched(_ result: Bool) {
        if result == true {
            continueButton.alpha = 1.0
        }
    }
    
    //MARK: - Private Methods
    
    private func fadeInGameOverWindow() {
        UIView.animate(withDuration: 0.8, delay: 0.4, options: [.allowUserInteraction], animations: {
            self.gameOverFrame.alpha = 1.0
        }, completion: nil )
    }
    
    
//    { finished in
//    //provide way to move on from Reaction Image view by tap
//    let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.goBack))
//    self.reactionImage.addGestureRecognizer(imageTap)
//    }
    
    private func roundCorners() {
        gameOverFrame.layer.cornerRadius = 15
        gameOverFrame.layer.masksToBounds = true
        playAdButton.layer.cornerRadius = 10
        playAdButton.layer.masksToBounds = true
    }
    
    private func wrongAnswer() {
        
        let whinePath = Bundle.main.path(forResource: "Sad Whine", ofType: "m4a")
        let whineUrl = URL.init(fileURLWithPath: whinePath!)
        
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: whineUrl)
        } catch {
            print ("audio file not found")
        }
        reactionImage.image = UIImage(named: getSadDogPhotoName())
        //gameOverLabel.text = "GAME OVER"
        //levelLabel.text = "You made it to \(gameSession!.currentDifficulty!) level \(gameSession!.getCurrentLevel())!!!"

        
        if gameSession.highScoresAndSettings!.soundOn  {
            audioPlayer.play()
        }
        

    }
    
    
    
    //go to start page
    @objc private func goBack() {
        
       
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var passToViewController: String
        
        passToViewController = "gameStartPageViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameStartPageViewController
        nextViewController.gameSession = gameSession
        self.present(nextViewController, animated: true, completion: nil)

       
        
    }
    
    private func getSadDogPhotoName() -> String {
        var returnString = "saddog"
        returnString += String(arc4random_uniform(3))
        return returnString
    }
    


}
