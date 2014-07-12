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
    let colorArray = [UIColor.blueColor(), UIColor.greenColor(), UIColor.redColor(), UIColor.yellowColor(), UIColor.purpleColor()];
    
    init(actionGroup:SKAction, delay:Int) {
        self.sprite.anchorPoint = CGPoint(x: 0, y: 0);
        self.sprite.alpha = 0.87;
        self.sprite.colorBlendFactor = 0.7;
        self.sprite.color = UIColor.blackColor();
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
        self.sprite.color = self.colorArray[Int(arc4random_uniform(UInt32(self.colorArray.count)))];

    }
}