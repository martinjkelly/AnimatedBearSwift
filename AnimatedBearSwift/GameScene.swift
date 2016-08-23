//
//  GameScene.swift
//  AnimatedBearSwift
//
//  Created by Martin Kelly on 22/08/2016.
//  Copyright (c) 2016 TheLADbibleGroup. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
    var bear: SKSpriteNode!
    var bearWalkingFrames: [SKTexture]!
    
    override func didMoveToView(view: SKView) {
    
        backgroundColor = (UIColor.blackColor())
        
        let bearAnimatedAtlas = SKTextureAtlas(named: "BearImages")
        var walkFrames = [SKTexture]()
        
        let numImages = bearAnimatedAtlas.textureNames.count
        
        for var i=1; i<=numImages/2; i += 1 {
            let bearTextureName = "bear\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        
        bearWalkingFrames = walkFrames
        
        let firstFrame = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrame)
        bear.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(bear)
        
        walkingBear()
    }
    
    func walkingBear() {
        
        bear.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(bearWalkingFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
            withKey:"walkingInPlaceBear"
        )
    }
    
    func bearMoveEnded() {
        bear.removeAllActions()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        var multiplierForDirection: CGFloat
        
        let bearVelocity = frame.size.width / 3
        
        let moveDifference = CGPointMake(location.x - bear.position.x, location.y - bear.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        
        let moveDuration = distanceToMove / bearVelocity
        
        if moveDifference.x < 0 {
            multiplierForDirection = 1.0
        } else {
            multiplierForDirection = -1.0
        }
        
        bear.xScale = fabs(bear.xScale) * multiplierForDirection
        
        // if the bear is moving. stop it. keep walking movement though.
        if bear.actionForKey("bearMoving") != nil {
            bear.removeActionForKey("bearMoving")
        }
        
        // if the legs aren't moving, start this now
        if bear.actionForKey("bearWalking") == nil {
            walkingBear()
        }
        
        let moveAction = SKAction.moveTo(location, duration: Double(moveDuration))
        
        let doneAction = SKAction.runBlock() {
            print("Animation complete")
            self.bearMoveEnded()
        }
        
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        bear.runAction(moveActionWithDone)
        
    }
}
