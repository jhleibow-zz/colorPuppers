//
//  HighScoresAndSettings.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/8/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import Foundation

class HighScoresAndSettings: NSObject, NSCoding {
 
    //MARK: - Properties
    
    var easyHighScore: Int
    var mediumHighScore: Int
    var hardHighScore: Int
    var soundOn: Bool
    var musicOn: Bool
    
    
    //MARK: - Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("scores")
    
    
    //MARK: - Types
    
    struct PropertyKey {
        static let easyHighScore = "easyHighScore"
        static let mediumHighScore = "mediumHighScore"
        static let hardHighScore = "hardHighScore"
        static let soundOn = "soundOn"
        static let musicOn = "musicOn"
    }
    
    
    //MARK: - Initialization
    init(easyHighScore: Int?, mediumHighScore: Int?, hardHighScore: Int?, soundOn: Bool?, musicOn: Bool?) {

        if easyHighScore == nil {
            self.easyHighScore = 0
        } else {
            self.easyHighScore = easyHighScore!
        }
        
        if mediumHighScore == nil {
            self.mediumHighScore = 0
        } else {
            self.mediumHighScore = mediumHighScore!
        }
        
        if hardHighScore == nil {
            self.hardHighScore = 0
        } else {
            self.hardHighScore = hardHighScore!
        }
        
        if soundOn == nil {
            self.soundOn = true
        } else {
            self.soundOn = soundOn!
        }
        
        if musicOn == nil {
            self.musicOn = true
        } else {
            self.musicOn = musicOn!
        }
       
    }
     
    
    //MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(easyHighScore, forKey: PropertyKey.easyHighScore)
        aCoder.encode(mediumHighScore, forKey: PropertyKey.mediumHighScore)
        aCoder.encode(hardHighScore, forKey: PropertyKey.hardHighScore)
        aCoder.encode(soundOn, forKey: PropertyKey.soundOn)
        aCoder.encode(musicOn, forKey: PropertyKey.musicOn)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let easyHighScore = aDecoder.decodeInteger(forKey: PropertyKey.easyHighScore)
        let mediumHighScore = aDecoder.decodeInteger(forKey: PropertyKey.mediumHighScore)
        let hardHighScore = aDecoder.decodeInteger(forKey: PropertyKey.mediumHighScore)
        let soundOn = aDecoder.decodeBool(forKey: PropertyKey.soundOn)
        let musicOn = aDecoder.decodeBool(forKey: PropertyKey.musicOn)
        
        self.init(easyHighScore: easyHighScore, mediumHighScore: mediumHighScore, hardHighScore: hardHighScore, soundOn: soundOn, musicOn: musicOn)
    }
    
    
    //MARK: - Public Methods
    
    func getHardHighScore() -> Int {
        return hardHighScore
    }
    
    func getMediumHighScore() -> Int {
        return mediumHighScore
    }
    
    func getEasyHighScore() -> Int {
        return easyHighScore
    }

    
}
