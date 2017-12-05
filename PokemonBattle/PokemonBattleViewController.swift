//
//  PokemonBattleViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleViewController

import RealmSwift
import SpriteKit
import UIKit

public final class PokemonBattleViewController: UIViewController, PokemonBattleDataProvider, BattleFieldSceneDataProvider {
    
    // MARK: Property
    
    private final let gameView = SKView()
    
    public final var battleFieldScene: BattleFieldScene? {
        
        return gameView.scene as? BattleFieldScene
        
    }
    
    private final let server: TurnBasedBattleServer
    
    private final let system = PokemonBattleSystem()
    
    private final let ownerId = UUID().uuidString
    
    private final let recordId = UUID().uuidString
    
    public final let homeBattlePokemonId: String
    
    public final let homeBattlePokemonImage: UIImage
    
    public final let guestBattlePokemonId: String
    
    public final let guestBattlePokemonImage: UIImage
    
    private final var context: PokemonBattleContext
    
    // MARK: Init
    
    public init(
        server: TurnBasedBattleServer,
        homeBattlePokemonId: String,
        homeBattlePokemonImage: UIImage,
        guestBattlePokemonId: String,
        guestBattlePokemonImage: UIImage,
        context: PokemonBattleContext
    ) {
        
        self.server = server
        
        self.homeBattlePokemonId = homeBattlePokemonId
        
        self.homeBattlePokemonImage = homeBattlePokemonImage
        
        self.guestBattlePokemonId = guestBattlePokemonId
        
        self.guestBattlePokemonImage = guestBattlePokemonImage
        
        self.context = context
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: View Life Cycle
    
    public final override func loadView() { self.view = gameView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Skill",
            style: .plain,
            target: self,
            action: #selector(selectSkill)
        )
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let startScene = SKScene(fileNamed: "BattleStartScene")!
        
        startScene.scaleMode = .aspectFill
        
        gameView.presentScene(startScene)
        
        server.serverDelegate = self
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if server.state == .end { server.resume() }
        
    }
    
    // MARK: Action
    
    @objc public final func selectSkill(_ sender: Any) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let battleFieldScene = self.battleFieldScene!
        
        let lightningSkill = LightningPokemonSkill()
        
        let fireSkill = FirePokemonSkill()
        
        let lightningSkillProvider = lightningSkill.makeProvider(
            id: UUID().uuidString,
            priority: 100.0 + homeBattlePokemon.speed,
            sourceId: homeBattlePokemon.id,
            destinationIds: [ guestBattlePokemon.id ],
            context: PokemonSkillAnimatorContext(
                sourceId: homeBattlePokemon.id,
                sourceSprite: battleFieldScene.homePokemonSpriteNode,
                sourceHPLabel: battleFieldScene.homeHpLabelNode,
                destinationId: guestBattlePokemon.id,
                destinationSprite: battleFieldScene.guestPokemonSpriteNode,
                destinationHPLabel: battleFieldScene.guestHpLabelNode
            )
        )

        let fireSkillProvider = fireSkill.makeProvider(
            id: UUID().uuidString,
            priority: 100.0 + guestBattlePokemon.speed,
            sourceId: guestBattlePokemon.id,
            destinationIds: [ homeBattlePokemon.id ],
            context: PokemonSkillAnimatorContext(
                sourceId: guestBattlePokemon.id,
                sourceSprite: battleFieldScene.guestPokemonSpriteNode,
                sourceHPLabel: battleFieldScene.guestHpLabelNode,
                destinationId: homeBattlePokemon.id,
                destinationSprite: battleFieldScene.homePokemonSpriteNode,
                destinationHPLabel: battleFieldScene.homeHpLabelNode
            )
        )
        
        system
            .respond(to: fireSkillProvider)
            .respond(to: lightningSkillProvider)
            .run(with: context)
            .then(in: .main) { context in

                self.context = context

                battleFieldScene.updateData()

                self.server
                    .respond(
                        to: PlayerInvolveBattleRequest(playerId: self.ownerId)
                    )

            }
            .catch(in: .main) { error in

                print("\(error)")

            }

    }
    
    // MARK: PokemonBattleDataProvider
 
    public final var homeBattlePokemon: BattlePokemon {
        
        return context.storage[homeBattlePokemonId]!
        
    }
    
    public final var guestBattlePokemon: BattlePokemon {
        
        return context.storage[guestBattlePokemonId]!
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

import TinyBattleKit

extension PokemonBattleViewController: TurnBasedBattleServerDelegate {
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        let battleFieldScene = BattleFieldScene(
            size: gameView.bounds.size
        )
        
        battleFieldScene.name = "battleScene"
        
        battleFieldScene.scaleMode = .aspectFill
        
        battleFieldScene.sceneDataProvider = self
        
        battleFieldScene.updateData()
        
        gameView.presentScene(battleFieldScene)
        
//        server.respond(
//            to: ContinueBattleRequest(ownerId: server.owner.id)
//        )
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) { navigationItem.rightBarButtonItem?.isEnabled = true }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) { }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) { print("\(error)") }
    
}
