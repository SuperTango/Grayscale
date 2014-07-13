//
//  GameViewController.swift
//  Grayscale
//
//  Created by Stephen Haney on 7/12/14.
//  Copyright (c) 2014 Stephen Haney. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        
        var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
}

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    var gestureRecognizer: UIPanGestureRecognizer?
    var tapGestureRecognizer: UITapGestureRecognizer?
    var buttonViewArray = [UIView]()
    var currentPressedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            scene.size = CGSize(width: 320, height: 568);
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = SKSceneScaleMode.ResizeFill
            
            skView.presentScene(scene)
        }
        
        // Play notes
        addButtons();
        addGestureRecongnizer();
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // Sean added the code below
    
    func addGestureRecongnizer() {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPanGesture:")
        
        if let newTapGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            newTapGestureRecognizer.delegate = self
        }
        
        self.view.addGestureRecognizer(gestureRecognizer)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTapGesture:")
        
        if let newTapGestureRecognizer = tapGestureRecognizer as? UITapGestureRecognizer {
            newTapGestureRecognizer.delegate = self
        }

        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func onPanGesture(gestureRecognizer: UIGestureRecognizer) {
        switch (gestureRecognizer.state) {
        case .Changed:
            var position = gestureRecognizer.locationInView(self.view)
            var verticalPercent = position.y / 480.0
            var horizontalPercent = position.x / 320.0
            
            self.view.backgroundColor = UIColor(red: CGFloat(verticalPercent), green: 0.5, blue: 0.5, alpha: 1.0)
            
            showButtonBasedOnVerticalPositionWhenChanged(position.y)
            
        default:
            return
        }
    }
    
    func onTapGesture(gestureRecognizer: UIGestureRecognizer) {
        var position = gestureRecognizer.locationInView(self.view)
        showButtonBasedOnVerticalPosition(position.y)
    }
    
    func addButtons() {
        var eachHeight = 480.0 / 5.0;
        
        var i = 0;
        for (i=0;i<5;i++) {
            var newView = UIView()
            newView.frame.origin.x = 0
            
            var nextPosition = CGFloat(CGFloat(eachHeight) * CGFloat(i))
            newView.frame.origin.y = nextPosition
            newView.frame.size.width = 320.0
            newView.frame.size.height = CGFloat(eachHeight)
            
            newView.backgroundColor = UIColor.whiteColor()
            newView.alpha = 0.0
            buttonViewArray += newView
            
            self.view.addSubview(newView)
        }
    }
    
    func showButtonBasedOnVerticalPositionWhenChanged(position: CGFloat) {
        var index = floor(position / 480.0 * 5)
        if (currentPressedIndex != index) {
            currentPressedIndex = Int(index);
            
            var targetView = buttonViewArray[Int(index)]
            targetView.alpha = 0.4
            
            UIView.animateWithDuration(0.6, animations: {
                targetView.alpha = 0.0
                })
        }
    }

    func showButtonBasedOnVerticalPosition(position: CGFloat) {
        var index = floor(position / 480.0 * 5)
        var targetView = buttonViewArray[Int(index)]
        targetView.alpha = 0.4
        
        UIView.animateWithDuration(0.6, animations: {
            targetView.alpha = 0.0
            })
    }
    
    // Gesture delegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }
}
