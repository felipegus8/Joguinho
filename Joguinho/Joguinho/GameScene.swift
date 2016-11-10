//
//  GameScene.swift
//  Joguinho
//
//  Created by Andre Machado Parente on 10/21/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1
    static let Projectile: UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var spaceship: Spaceship!
    var fuelDrops: SurvivalArtifact!
    let progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
    var surface = Component(imageNamed: "NeptuneSurface")
    var surface2 = Component(imageNamed: "NeptuneSurface")
    var background = Component(imageNamed:"background")
    var bigrock = Component(imageNamed: "rock1")
    var smallrock = Component(imageNamed: "rock2")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.115)
        physicsWorld.contactDelegate = self
        
        spaceship = Spaceship(fuelLevel: 100)
        spaceship.physicsBody = SKPhysicsBody(texture: spaceship.texture!,
                                              size: CGSize(width: spaceship.size.width, height: spaceship.size.height))
        spaceship.physicsBody?.affectedByGravity = true
        spaceship.physicsBody?.isDynamic = true
        spaceship.physicsBody?.usesPreciseCollisionDetection = true
        spaceship.physicsBody?.collisionBitMask = PhysicsCategory.None
//        spaceship.physicsBody?.categoryBitMask = PhysicsCategory.Monster
//        spaceship.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        
        progressView.center = CGPoint(x: 300, y: 40)
        progressView.progress = 0.8
        progressView.progressTintColor = UIColor.white
        progressView.backgroundColor = UIColor.orange
        
        surface.position = CGPoint(x: 0, y: surface.size.height/3)
        surface.zPosition = 2
        surface.size = CGSize(width: UIScreen.main.bounds.width + 600, height: surface.size.height)
        
        surface2.position = CGPoint(x: surface.size.width, y: surface.size.height/3)
        surface2.zPosition = 2
        surface2.size = CGSize(width: UIScreen.main.bounds.width + 600, height: surface.size.height)
        
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = 1
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        spaceship.position = CGPoint(x: 50, y: 150)
        spaceship.zPosition = 10
        
        bigrock.position = CGPoint(x:1000,y:200)
        bigrock.zPosition = 10
        bigrock.physicsBody = SKPhysicsBody(texture: bigrock.texture!,
                                            size: CGSize(width: bigrock.size.width, height: bigrock.size.height))
        bigrock.physicsBody?.affectedByGravity = false
        
        fuelDrops = SurvivalArtifact(type: Artifact(rawValue: "Fuel")!)
        fuelDrops.position = CGPoint(x:500,y:50)
        fuelDrops.zPosition = 10
        
        smallrock.position = CGPoint(x:1000,y:80)
        smallrock.zPosition = 10
        smallrock.physicsBody = SKPhysicsBody(texture: smallrock.texture!,
                                              size: CGSize(width: smallrock.size.width, height: smallrock.size.height))
        smallrock.physicsBody?.affectedByGravity = false
        
        self.addChild(spaceship)
        self.addChild(surface)
        self.addChild(surface2)
        self.addChild(background)
        self.addChild(bigrock)
        self.addChild(fuelDrops)
        self.addChild(smallrock)
        view.addSubview(progressView)
      
    }
    override func sceneDidLoad() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let spaceshipMove = SKAction.applyImpulse(CGVector(dx: 0, dy: 5), duration: 0.1)
        spaceship.run(spaceshipMove)
        
        let rockMove2 = SKAction.applyForce(CGVector(dx: -2, dy: 0), duration: 0.5)
        smallrock.run(rockMove2)
        let rockMove = SKAction.applyImpulse(CGVector(dx: -2, dy:0), duration: 0.5)
        bigrock.run(rockMove)
    }
    
    override func update(_ currentTime: TimeInterval) {
        surface.position = CGPoint(x:surface.position.x - 5,y:surface.position.y)
        surface2.position = CGPoint(x:surface2.position.x - 5,y:surface2.position.y)
        
        if surface.position.x <= -surface.size.width
        {
            surface.position = CGPoint(x:surface2.position.x + surface2.size.width,y:surface.position.y)
        }
        if surface2.position.x <= -surface2.size.width
        {
            surface2.position = CGPoint(x:surface.position.x + surface.size.width,y:surface2.position.y)
        }
        
        // Spaceship is off bounderies
        if spaceship.position.y < 0 || spaceship.position.y > UIScreen.main.bounds.height {
            print("\nYou're dead.\n")
        }
        else {
            print("\nYou're NOT dead.\n")
        }
    }
    
}
