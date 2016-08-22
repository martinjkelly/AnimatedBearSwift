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
}
