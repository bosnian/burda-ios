//
//  GameScene.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Hello SpriteKit!")
    var circle = SKShapeNode(circleOfRadius: 10 ) // Size of Circle
    
    var userPosition = 0.0
    
    var tiles = [SKSpriteNode]()
    
    var pointIndexes = [0,1,2,3,4,5,4,3,2,1,0,1,2,3,4,5]
    
    override func didMove(to view: SKView) {
        label.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        label.fontSize = 45
        label.fontColor = SKColor.yellow
        label.fontName = "Avenir"
        addChild(label)
        
        
        circle.position = CGPoint(x: frame.width / 2,y:30)
        circle.strokeColor = SKColor.white
        circle.glowWidth = 1.0
        circle.zPosition = 10
        circle.fillColor = SKColor.white
        self.addChild(circle)
        
        let tilesWide = pointIndexes.count * 2
        let tilesTall = 6
        
        let tileWidth = (frame.width/6) - 10
        let tileHeight = (frame.height / CGFloat(tilesTall)) - 10
        
        for i in 0..<tilesWide {
            if i % 2 == 0 {
                continue
            }
            for j in 0..<tilesTall {
                
                let tile = SKSpriteNode(color: SKColor.red, size: CGSize(width: tileWidth, height: tileHeight))
                tile.anchorPoint = .zero
                
                let x = frame.width - 50 +  -1 * tileWidth/2 + CGFloat(i) * (tile.size.width + 10)
                let y = 5 + CGFloat(j) * (tile.size.height + 10)
                
                tile.position = CGPoint(x: x, y: y)
                if  pointIndexes[i/2] == j {
                    self.addChild(tile)
                    tiles.append(tile)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        let target = 30  + (CGFloat(userPosition) * (frame.height - 60))
        
        let action = SKAction.moveTo(y: target, duration: 0.5)
        action.timingMode = .easeOut
        circle.run(action)
        
        
        for tile in tiles {
            tile.position.x -= 1
        }
        
    }
    
}


