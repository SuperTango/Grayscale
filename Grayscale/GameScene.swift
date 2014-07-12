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
        self.size = CGSize(width: 320, height: 568);
        self.backgroundColor = UIColor.whiteColor();
      
        let keyAnimation:SKAction = SKAction.group([
            SKAction.scaleTo(0.3, duration: 4),
            SKAction.moveTo(CGPoint(x: -200, y: -350), duration: 4),
        ]);
        
        for i in 0...4 {
            let newKey = PianoKey(actionGroup: keyAnimation, delay: i);
            self.addChild(newKey.sprite);
            newKey.startAnimation();
            self.keys.append(newKey);
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
        
        let speed = (-1 * self.visuals.power - 20) / 2;
        self.speed = CGFloat(speed < 0.2 ? 0.2 : speed);
    }
}
