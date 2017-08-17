//
//  BadgesViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 8/7/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class BadgesViewController: UIViewController {

    
    @IBOutlet weak var transparentGoBackButton: UIButton!

    @IBOutlet weak var badgesLabel: UILabel!
    
    @IBOutlet weak var badgeeasy1: UIImageView!
    @IBOutlet weak var badgemedium1: UIImageView!
    @IBOutlet weak var badgehard1: UIImageView!
    
    @IBOutlet weak var badgeeasy2: UIImageView!
    @IBOutlet weak var badgemedium2: UIImageView!
    @IBOutlet weak var badgehard2: UIImageView!
    
    @IBOutlet weak var badgeeasy3: UIImageView!
    @IBOutlet weak var badgemedium3: UIImageView!
    @IBOutlet weak var badgehard3: UIImageView!
    
    @IBOutlet weak var badgeeasy4: UIImageView!
    @IBOutlet weak var badgemedium4: UIImageView!
    @IBOutlet weak var badgehard4: UIImageView!
    
    @IBAction func transparentGoBackButtonTap(_ sender: UIButton) {
        goBack()
    }
    
    
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
    var sendingViewControllerName: String!
    
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadBadges()
        Utilities.updateLabelFontAttributed(label: badgesLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 5.0, scaleDownFromHeightFactor: 2.7)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //navigate to prior page
    private func goBack() {
        if sendingViewControllerName == "settingsViewControllerID" {
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! SettingsViewController
            nextViewController.gameSession = gameSession
            self.present(nextViewController, animated: true, completion: nil)
        } else {
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! GameStartPageViewController
            nextViewController.gameSession = gameSession
            self.present(nextViewController, animated: true, completion: nil)
        }
        

    }
    
    private func loadBadges() {
        
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level1 {
            badgeeasy1.image = UIImage(named:"badgeeasy1")
        } else {
            badgeeasy1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level2 {
            badgeeasy2.image = UIImage(named:"badgeeasy2")
        } else {
            badgeeasy2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level3 {
            badgeeasy3.image = UIImage(named:"badgeeasy3")
        } else {
            badgeeasy3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level4 {
            badgeeasy4.image = UIImage(named:"badgeeasy4")
        } else {
            badgeeasy4.image = UIImage(named:"badgeempty4")
        }
        
        
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level1 {
            badgemedium1.image = UIImage(named:"badgemedium1")
        } else {
            badgemedium1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level2 {
            badgemedium2.image = UIImage(named:"badgemedium2")
        } else {
            badgemedium2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level3 {
            badgemedium3.image = UIImage(named:"badgemedium3")
        } else {
            badgemedium3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level4 {
            badgemedium4.image = UIImage(named:"badgemedium4")
        } else {
            badgemedium4.image = UIImage(named:"badgeempty4")
        }
        
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level1 {
            badgehard1.image = UIImage(named:"badgehard1")
        } else {
            badgehard1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level2 {
            badgehard2.image = UIImage(named:"badgehard2")
        } else {
            badgehard2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level3 {
            badgehard3.image = UIImage(named:"badgehard3")
        } else {
            badgehard3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level4 {
            badgehard4.image = UIImage(named:"badgehard4")
        } else {
            badgehard4.image = UIImage(named:"badgeempty4")
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
