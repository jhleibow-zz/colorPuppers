//
//  GameSession.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/8/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import Foundation
import AVFoundation
import GoogleMobileAds


//MARK: - Protocols
protocol GameSessionAdDelegate: class {
    func adWasWatched(_ result: Bool)
}

protocol GameSessionAnimationDelegate: class{
    func focusReturnedStartAnimationAgain()
}


class GameSession: NSObject, GADRewardBasedVideoAdDelegate, UIViewControllerAnimatedTransitioning {
    

    
    //MARK: - Properties
    
    weak var adDelegate: GameSessionAdDelegate?
    weak var animationDelegate: GameSessionAnimationDelegate?
    
    var miniGame = MiniGame()
    private var currentLevel = 1
    var currentDifficulty: Difficulty?
    var highScoresAndSettings: HighScoresAndSettings?
    var gameColorsAndObjects = GameColorsAndObjects()
    
    var stageTypeUnlocked = 0
    var fillerUnlocked = 0
    var relationshipUnlocked = 0
    var distributionUnlocked = 0
    
    var watchedAd = false
    
    var numberOfAdsWatchedThisGame = 0
    
    var highScoreCongratulationsShown: Bool = false
    
    var audioPlayer: AVAudioPlayer!
    
    var rewardVideo: GADRewardBasedVideoAd?

    //MARK: - Types
    
    enum Difficulty {
        case easy
        case medium
        case hard
    }
    
    //MARK: - Initialization
    
    override init () {
        super.init()
        if let highScoresAndSettings = loadScoresAndSettings() {
            self.highScoresAndSettings = highScoresAndSettings
        } else {
            self.highScoresAndSettings = HighScoresAndSettings(easyHighScore: nil, mediumHighScore: nil, hardHighScore: nil, soundOn: nil, musicOn: nil)
        }
        
        //oberserver for when game loses focus
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(pauseGame), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(unpauseGame), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
        //start the music!
        if highScoresAndSettings!.soundOn {
            playMusic()
        }
        
        //reward video
        rewardVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardVideo?.delegate = self
        rewardVideo?.load(GADRequest(), withAdUnitID: GamePlayParameters.AdMob.testAdUnitID)
    }
    

    //MARK: - Public Methods
    
    func minigamePassed() {
        incrementCurrentLevel()
        
    }
    
    func miniGameFailed() {
        updateHighScores()
        if rewardVideo?.isReady == false {
            rewardVideo?.load(GADRequest(), withAdUnitID: GamePlayParameters.AdMob.testAdUnitID)
        }
    }
    
    func startNewGame(difficulty: GameSession.Difficulty) {
        resetCurrentAndUnlockedLevel()
        highScoreCongratulationsShown = false
        currentDifficulty = difficulty
    }
    
    func updateHighScores() {

        let passedLevel = getCurrentLevel() - 1
        
        switch currentDifficulty! {
           
        case GameSession.Difficulty.easy:
            if highScoresAndSettings!.easyHighScore < passedLevel {
                highScoresAndSettings!.easyHighScore = passedLevel
            }
            
        case GameSession.Difficulty.medium:
            if highScoresAndSettings!.mediumHighScore < passedLevel {
                highScoresAndSettings!.mediumHighScore = passedLevel
            }
        case GameSession.Difficulty.hard:
            if highScoresAndSettings!.hardHighScore < passedLevel {
                highScoresAndSettings!.hardHighScore = passedLevel
            }
        }
        
        saveScoresAndSettings()
    }
        
    func saveScoresAndSettings() {
        if highScoresAndSettings != nil {
            let saved = NSKeyedArchiver.archiveRootObject(highScoresAndSettings!, toFile: HighScoresAndSettings.ArchiveURL.path)
            if saved {
                print("Save successful")
            } else {
                print("Save failed")
            }
        }
    }
    
    func resetHighScores() {
        highScoresAndSettings!.easyHighScore = 0
        highScoresAndSettings!.mediumHighScore = 0
        highScoresAndSettings!.hardHighScore = 0
        saveScoresAndSettings()
        
    }
    
    func resetCurrentAndUnlockedLevel() {
        numberOfAdsWatchedThisGame = 0
        currentLevel = 1
        stageTypeUnlocked = 0
        fillerUnlocked = 0
        relationshipUnlocked = 0
        distributionUnlocked = 0
    }
    
    func incrementCurrentLevel() {
        currentLevel += 1
        
        updateStageTypeUnlocked()
        updateFillerUnlocked()
        updateRelationshipUnlocked()
        updateDistributionUnlocked()
        
    }
    
    func getCurrentLevel() -> Int {
        return currentLevel
    }
    
    func playMusic() {
        
        let musicPath = Bundle.main.path(forResource: "funky", ofType: "mp3")
        let musicUrl = URL.init(fileURLWithPath: musicPath!)
        
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl)
        } catch {
            print ("audio file not found")
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.volume = 0.27
        audioPlayer.play()
    }
    
    func stopMusic() {
        if audioPlayer != nil {
            audioPlayer.pause()
        }
    }
    
    
    @objc func pauseGame() {
        if audioPlayer != nil {
            audioPlayer.pause()
        }
        
    }
    
    @objc func unpauseGame() {
        if highScoresAndSettings!.musicOn {
            audioPlayer.play()
        }
        animationDelegate?.focusReturnedStartAnimationAgain()
        print("animation delegate just ran?")
    }
    
    
    //MARK: - Private Methods
    private func loadScoresAndSettings() -> HighScoresAndSettings? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: HighScoresAndSettings.ArchiveURL.path) as? HighScoresAndSettings
    }
    
    private func updateStageTypeUnlocked() {
        
        var promotionModulo: Int
        var maxStage: Int
        var stagePromotionJump: Int
        
        switch currentDifficulty! {
        case GameSession.Difficulty.easy:
            promotionModulo = GamePlayParameters.StageGeneration.easyNumLevelsUntilStageTypePromotion
            maxStage = GamePlayParameters.StageGeneration.easyMaxStageType
            stagePromotionJump = GamePlayParameters.StageGeneration.easyStageTypePromotionCount
        case GameSession.Difficulty.medium:
            promotionModulo = GamePlayParameters.StageGeneration.mediumNumLevelsUntilStageTypePromotion
            maxStage = GamePlayParameters.StageGeneration.mediumMaxStageType
            stagePromotionJump = GamePlayParameters.StageGeneration.mediumStageTypePromotionCount
        case GameSession.Difficulty.hard:
            promotionModulo = GamePlayParameters.StageGeneration.hardNumLevelsUntilStageTypePromotion
            maxStage = GamePlayParameters.StageGeneration.hardMaxStageType
            stagePromotionJump = GamePlayParameters.StageGeneration.hardStageTypePromotionCount
        }
        
        //Unlock another stage if exactly divisible by promotionModulo and not above max stage
        if getCurrentLevel() % promotionModulo == 0 && stageTypeUnlocked < maxStage{
            stageTypeUnlocked += stagePromotionJump
            if stageTypeUnlocked > maxStage {
                stageTypeUnlocked = maxStage
            }
        }

    }
    

    
    private func updateFillerUnlocked() {
        
        var promotionModulo: Int
        var maxFiller: Int
        var FillerPromotionJump: Int
        
        switch currentDifficulty! {
        case GameSession.Difficulty.easy:
            promotionModulo = GamePlayParameters.StageGeneration.easyNumLevelsUntilFillerPromotion
            maxFiller = GamePlayParameters.StageGeneration.easyMaxFiller
            FillerPromotionJump = GamePlayParameters.StageGeneration.easyFillerPromotionCount
        case GameSession.Difficulty.medium:
            promotionModulo = GamePlayParameters.StageGeneration.mediumNumLevelsUntilFillerPromotion
            maxFiller = GamePlayParameters.StageGeneration.mediumMaxFiller
            FillerPromotionJump = GamePlayParameters.StageGeneration.mediumFillerPromotionCount
        case GameSession.Difficulty.hard:
            promotionModulo = GamePlayParameters.StageGeneration.hardNumLevelsUntilFillerPromotion
            maxFiller = GamePlayParameters.StageGeneration.hardMaxFiller
            FillerPromotionJump = GamePlayParameters.StageGeneration.hardFillerPromotionCount
        }
        
        //Unlock another stage if exactly divisible by promotionModulo and not above max stage
        if getCurrentLevel() % promotionModulo == 0 && fillerUnlocked < maxFiller{
            fillerUnlocked += FillerPromotionJump
            if fillerUnlocked > maxFiller {
                fillerUnlocked = maxFiller
            }
        }
        
    }
    
    
    private func updateRelationshipUnlocked() {
        
        var promotionModulo: Int
        var maxRelationship: Int
        var RelationshipPromotionJump: Int
        
        switch currentDifficulty! {
        case GameSession.Difficulty.easy:
            promotionModulo = GamePlayParameters.StageGeneration.easyNumLevelsUntilRelationshipPromotion
            maxRelationship = GamePlayParameters.StageGeneration.easyMaxRelationship
            RelationshipPromotionJump = GamePlayParameters.StageGeneration.easyRelationshipPromotionCount
        case GameSession.Difficulty.medium:
            promotionModulo = GamePlayParameters.StageGeneration.mediumNumLevelsUntilRelationshipPromotion
            maxRelationship = GamePlayParameters.StageGeneration.mediumMaxRelationship
            RelationshipPromotionJump = GamePlayParameters.StageGeneration.mediumRelationshipPromotionCount
        case GameSession.Difficulty.hard:
            promotionModulo = GamePlayParameters.StageGeneration.hardNumLevelsUntilRelationshipPromotion
            maxRelationship = GamePlayParameters.StageGeneration.hardMaxRelationship
            RelationshipPromotionJump = GamePlayParameters.StageGeneration.hardRelationshipPromotionCount
        }
        
        //Unlock another stage if exactly divisible by promotionModulo and not above max stage
        if getCurrentLevel() % promotionModulo == 0 && relationshipUnlocked < maxRelationship{
            relationshipUnlocked += RelationshipPromotionJump
            if relationshipUnlocked > maxRelationship {
                relationshipUnlocked = maxRelationship
            }
        }
        
    }
    
    private func updateDistributionUnlocked() {
        
        var promotionModulo: Int
        
        switch currentDifficulty! {
        case GameSession.Difficulty.easy:
            promotionModulo = GamePlayParameters.StageGeneration.easyNumLevelsUntilDistributionPromotion
        case GameSession.Difficulty.medium:
            promotionModulo = GamePlayParameters.StageGeneration.mediumNumLevelsUntilDistributionPromotion
        case GameSession.Difficulty.hard:
            promotionModulo = GamePlayParameters.StageGeneration.hardNumLevelsUntilDistributionPromotion
        }
        
        //Unlock another stage if exactly divisible by promotionModulo and not above max stage
        if getCurrentLevel() % promotionModulo == 0 && distributionUnlocked < GamePlayParameters.StageGeneration.maxNumOfDistributions {
            distributionUnlocked += 1
         }
        
    }
    
    //MARK: - GADRewardBasedVideoAdDelegate
    
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        //adRequestInProgress = false
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        //adRequestInProgress = false
        print("Reward based video ad is received.")

    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        rewardVideo?.load(GADRequest(), withAdUnitID: GamePlayParameters.AdMob.testAdUnitID)
        adDelegate?.adWasWatched(false)
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        watchedAd = true
        //load next video
        rewardVideo?.load(GADRequest(), withAdUnitID: GamePlayParameters.AdMob.testAdUnitID)
        numberOfAdsWatchedThisGame = numberOfAdsWatchedThisGame + 1
        adDelegate?.adWasWatched(true)
        
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return GamePlayParameters.TransitionTiming.gameTransitionTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        toView.clipsToBounds = true
        fromView.clipsToBounds = true

        
        var forwards = true
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        
        //cases transition should go backwards
        if fromViewController is BadgesViewController ||
            fromViewController is AboutPuppersViewController ||
            (fromViewController is SettingsViewController && toViewController is GameStartPageViewController) {
            forwards = false
        }
        
        if forwards {
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            toView.frame.origin.x = fromView.frame.size.width * 1.01
            UIView.animate(withDuration: GamePlayParameters.TransitionTiming.gameTransitionTime, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0,
                           animations: {
                            toView.frame.origin.x = 0
            },
                           completion: { _ in
                            transitionContext.completeTransition(true)
            })
        } else {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            UIView.animate(withDuration: GamePlayParameters.TransitionTiming.gameTransitionTime, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0,
                           animations: {
                            fromView.frame.origin.x = fromView.frame.size.width * 1.01
            },
                           completion: { _ in
                            transitionContext.completeTransition(true)
            })
        }

    }
}
