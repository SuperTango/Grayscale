//
//  GameScene.swift
//  Grayscale
//
//  Created by Stephen Haney on 7/12/14.
//  Copyright (c) 2014 Stephen Haney. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let visuals = VisualLogic();
    var keys:[PianoKey] = [];
    
    override func didMoveToView(view: SKView) {
        self.size = CGSize(width: 320, height: 480);
        self.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
      
        let keyAnimation:SKAction = SKAction.group([
            SKAction.scaleTo(0.3, duration: 4),
            SKAction.moveTo(CGPoint(x: -200, y: -350), duration: 4),
        ]);
        //keyAnimation.timingMode = SKActionTimingMode.EaseIn;
        
        for i in 0...10 {
            let newKey = PianoKey(actionGroup: keyAnimation, delay: Float(i) * Float(1));
            self.addChild(newKey.sprite);
            newKey.startAnimation();
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location);
            let touchedKey = self.keys.filter { $0.sprite === touchedNode };
            
            if touchedKey.count > 0
            {
                // if we touched a tile, fire its tap event
                touchedKey[0].onTap();
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.visuals.update(currentTime);
        
        let speed = CGFloat (self.visuals.power * -1 - 10) / 25;
        self.speed = (speed < 0.2 ? 0.2 : speed)
    }
}
