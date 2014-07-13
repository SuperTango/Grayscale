//
//  VisualLogic.swift
//  Grayscale
//
//  Created by Stephen Haney on 7/12/14.
//  Copyright (c) 2014 Stephen Haney. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class VisualLogic {
    let audioPlayer:AVAudioPlayer;
    var power:Float = 0;
    
    init() {
        let audioUrl = NSURL(string: NSBundle.mainBundle().pathForResource("test", ofType: "aif"));
        var audioError:NSError?;
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: audioUrl, error: &audioError);
        self.audioPlayer.numberOfLoops = -1;

        self.audioPlayer.pause();
        self.audioPlayer.volume = 1.0
        self.audioPlayer.play();
        self.audioPlayer.meteringEnabled = true;
    }
    
    func update(currentTime: CFTimeInterval) {
        if audioPlayer.playing {
            audioPlayer.updateMeters();
            
            let leftPower = audioPlayer.averagePowerForChannel(0);
            let rightPower = audioPlayer.averagePowerForChannel(1);

            self.power = leftPower + rightPower;
        }
    }
}
