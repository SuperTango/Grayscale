//
//  PianoKey.swift
//  Grayscale
//
//  Created by Stephen Haney on 7/12/14.
//  Copyright (c) 2014 Stephen Haney. All rights reserved.
//

import Foundation
import SpriteKit

class PianoKey {
    let sprite = SKSpriteNode(imageNamed: "key");
    let actionWithDelay:SKAction;
    let actionToLoop:SKAction;
    
    init(actionGroup:SKAction, delay:Float) {
        self.sprite.anchorPoint = CGPoint(x: 0, y: 0);
        self.actionWithDelay = SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(delay)),
            actionGroup
        ]);
        self.actionToLoop = actionGroup;
        
        self.reset();
    }
    
    func startAnimation() {
        self.sprite.runAction(self.actionWithDelay, completion: {
            self.reset();
            self.animate();
            })
    }
    
    func animate() {
        self.sprite.runAction(self.actionToLoop, completion: {
            self.reset();
            self.animate();
        });
    }
    
    func reset() {
        self.sprite.xScale = 0.1;
        self.sprite.yScale = 0.1;
        self.sprite.position = CGPoint(x: 0, y: 500);
    }
    
    
    func onTap() {
        
    }
}