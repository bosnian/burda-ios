//
//  GameScene.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let resultLabel = SKLabelNode(text: "")
    let partnerResultLabel = SKLabelNode(text: "")
    let waitingMessage = SKLabelNode(text: "")
    
    var circle: SKShapeNode? = SKShapeNode(circleOfRadius: 10 ) // Size of Circle
    var partnerCircle: SKShapeNode? = SKShapeNode(circleOfRadius: 10 ) // Size of Circle
    
    var hasPartner = false
    
    var userPosition = 0.0
    var partnerPosition = 0.0
    
    var result = 0
    var partnerResult = 0
    
    
    var userFinished = false
    var partnerFinished = false
    var gameFinished = false
    
    var tiles = [TileNode]()
    
    var gameStarted = false
    
    var gameFinishedCallback: EmptyCallback?
    
    var pointIndexes = [0,1,2,3,4,5,4,3,2,1,0,1,2,3,4,5]
    
    override func didMove(to view: SKView) {
        resultLabel.position = CGPoint(x: view.frame.width - 50, y: view.frame.height - 70)
        resultLabel.fontSize = 20
        resultLabel.fontColor = SKColor.white
        resultLabel.fontName = "Avenir"
        resultLabel.zPosition = 15
        addChild(resultLabel)
        
        if hasPartner {
            partnerResultLabel.position = CGPoint(x: view.frame.width - 100, y: view.frame.height - 110)
            partnerResultLabel.fontSize = 20
            partnerResultLabel.fontColor = SKColor.white
            partnerResultLabel.fontName = "Avenir"
            partnerResultLabel.zPosition = 15
            addChild(partnerResultLabel)
        }
        
        waitingMessage.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        waitingMessage.fontSize = 40
        waitingMessage.text = "Waiting..."
        waitingMessage.zPosition = 15
        waitingMessage.fontColor = SKColor.white
        waitingMessage.fontName = "Avenir"
        addChild(waitingMessage)
        
        
        circle!.position = CGPoint(x: frame.width / 2,y:30)
        circle!.strokeColor = SKColor.white
        circle!.glowWidth = 1.0
        circle!.zPosition = 10
        circle!.fillColor = SKColor.white
        self.addChild(circle!)
        
        if hasPartner {
            partnerCircle!.position = CGPoint(x: frame.width / 2,y:30)
            partnerCircle!.strokeColor = SKColor.white
            partnerCircle!.glowWidth = 1.0
            partnerCircle!.zPosition = 10
            partnerCircle!.fillColor = SKColor.red
            self.addChild(partnerCircle!)
        }
        
        let tilesWide = pointIndexes.count * 2
        let tilesTall = 6
        
        let tileWidth = (frame.width/6) - 10
        let tileHeight = (frame.height / CGFloat(tilesTall)) - 10
        
        for i in 0..<tilesWide {
            if i % 2 == 0 {
                continue
            }
            for j in 0..<tilesTall {
                
                let tile = TileNode()
                tile.size = CGSize(width: tileWidth, height: tileHeight)
                tile.color = .red
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
        
        
        if gameStarted && gameFinished == false {
            
            waitingMessage.text = "Starting!"
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                self.waitingMessage.removeFromParent()
            })
            
            let target = 30  + (CGFloat(userPosition) * (frame.height - 60))
            
            let action = SKAction.moveTo(y: target, duration: 0.5)
            action.timingMode = .easeOut
            if let circle = circle {
                circle.run(action)
            }
            
            if hasPartner {
                let partnerTarget = 30  + (CGFloat(partnerPosition) * (frame.height - 60))
                
                let partnerAction = SKAction.moveTo(y: partnerTarget, duration: 0.5)
                partnerAction.timingMode = .easeOut
                if let partnerCircle = partnerCircle {
                    partnerCircle.run(partnerAction)
                }
            }
            
            for tile in tiles {
                tile.position.x -= 2
            }
            
            for tile in tiles {
                
                if let circle = circle {
                    if circle.intersects(tile) {
                        if tile.userEntered {
                            
                        } else {
                            tile.color = UIColor.clear
                            tile.userEntered = true
                            result = result + 1
                        }
                    }
                }
                
                if let partnerCircle = partnerCircle {
                    if partnerCircle.intersects(tile) {
                        if tile.partnerEntered {
                            
                        } else {
                            tile.partnerEntered = true
                            partnerResult = partnerResult + 1
                        }
                    }
                }
            }
        }
        
        resultLabel.text = "You: \(result)"
        
        if userFinished {
            resultLabel.fontColor = .red
            
            if hasPartner == false {
                gameFinishedCallback?()
                gameFinishedCallback = nil
            }
            
            if circle != nil {
                circle?.removeFromParent()
                circle = nil
            }
        } else {
            resultLabel.text = "You: \(result)"
        }
        
        if hasPartner {
            if partnerFinished {
                partnerResultLabel.fontColor = .red
                
                if partnerCircle != nil {
                    partnerCircle?.removeFromParent()
                    partnerCircle = nil
                }
                
            } else {
                partnerResultLabel.text = "\(Storage.Partner.firstName!): \(partnerResult)"
            }
            
            if userFinished && partnerFinished {
                gameFinishedCallback?()
                gameFinishedCallback = nil
            }
        }
    }
    
}


class TileNode: SKSpriteNode {
    var userEntered = false
    var partnerEntered = false
}

