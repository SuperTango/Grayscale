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
        self.backgroundColor = UIColor.whiteColor();
        
        let keyAnimation:SKAction = SKAction.group([
            SKAction.scaleTo(0.2, duration: 3.5),
            SKAction.moveTo(CGPoint(x: -200, y: -350), duration: 5),
        ]);
        keyAnimation.timingMode = SKActionTimingMode.EaseIn;
        
        /*
        let zoomIn = SKAction.group([ SKAction.scaleTo(1, duration: 2.8), SKAction.rotateByAngle(Float(M_PI * 2.0), duration: 2.8) ]);
        zoomIn.timingMode = SKActionTimingMode.EaseOut;
        canvas.runAction(zoomIn, completion: {
            game.performingIntro = false;
            self.shakeCamera(0.5);
            } );
        */
        
        /*let keyTest:PianoKey = PianoKey(position: CGPoint(x: 0, y: 500));
        keyTest.sprite.xScale = 0.1;
        keyTest.sprite.yScale = 0.1;
        self.addChild(keyTest.sprite);
        keys.append(keyTest);*/
        

        
        /*let keyTest2:PianoKey = PianoKey(position: CGPoint(x: 0, y: 500));
        keyTest2.sprite.xScale = 0.1;
        keyTest2.sprite.yScale = 0.1;
        self.addChild(keyTest2.sprite);
        keys.append(keyTest2);
        
        let delay:NSTimeInterval = 0.75;
        
        let keyAnimation2:SKAction = SKAction.sequence([ SKAction.waitForDuration(delay), SKAction.group([ SKAction.scaleTo(0.2, duration: 3.5), SKAction.moveTo(CGPoint(x: -200, y: -350), duration: 5) ]) ]);
        keyAnimation2.timingMode = SKActionTimingMode.EaseIn;
        
        keyTest2.sprite.runAction(keyAnimation2);*/
        
        /*let keyTest2:PianoKey = PianoKey(position: CGPoint(x: 0, y: 320));
        keyTest2.sprite.xScale = 0.16;
        keyTest2.sprite.yScale = 0.16;
        self.addChild(keyTest2.sprite);
        
        let keyTest3:PianoKey = PianoKey(position: CGPoint(x: 0, y: 180));
        keyTest3.sprite.xScale = 0.22;
        keyTest3.sprite.yScale = 0.22;
        self.addChild(keyTest3.sprite);
        
        let keyTest4:PianoKey = PianoKey(position: CGPoint(x: 0, y: 5));
        keyTest4.sprite.xScale = 0.28;
        keyTest4.sprite.yScale = 0.28;
        self.addChild(keyTest4.sprite);
        
        let keyTest5:PianoKey = PianoKey(position: CGPoint(x: 0, y: -190));
        keyTest5.sprite.xScale = 0.34;
        keyTest5.sprite.yScale = 0.34;
        self.addChild(keyTest5.sprite);*/
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
    }
}
