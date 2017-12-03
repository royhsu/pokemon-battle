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

public final class PokemonBattleViewController: UIViewController, BattlePokemonDataProvider {
    
    // MARK: Property
    
    private final let gameView = SKView()
    
    public final var battleFieldScene: BattleFieldScene? {
        
        return gameView.scene as? BattleFieldScene
        
    }
    
    private final var server: TurnBasedBattleServer!
    
    private final let system = BattleSystem()
    
    private final let serverDataProvider = RealmServerDataProvider()
    
    public final let homeBattlePokemon: BattlePokemon
    
    public final let guestBattlePokemon: BattlePokemon
    
    private final let ownerId = UUID().uuidString
    
    private final let recordId = UUID().uuidString
    
    private final var currentContext: PokemonBattleContext
    
    // MARK: Init
    
    public init(
        homeBattlePokemon: BattlePokemon,
        guestBattlePokemon: BattlePokemon
    ) {
        
        self.homeBattlePokemon = homeBattlePokemon
        
        self.guestBattlePokemon = guestBattlePokemon
        
        self.currentContext = try! PokemonBattleContext(
            battlePokemons: [ homeBattlePokemon, guestBattlePokemon ]
        )
        
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
        
        let realm = serverDataProvider.realm
        
        try! realm.write {
            
            let owner = BattlePlayerRealmObject(
                value: [ "id": ownerId ]
            )
            
            realm.add(owner)
            
            let record = BattleRecordRealmObject(
                value: [ "id": recordId ]
            )
            
            realm.add(record)
            
        }
        
        server = TurnBasedBattleServer(
            ownerId: ownerId,
            recordId: recordId
        )
        
        server.serverDataProvider = serverDataProvider
        
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
        
        system
            .respond(
                to: .lightningSkill(
                    id: UUID().uuidString,
                    sourceId: homeBattlePokemon.id,
                    destinationId: guestBattlePokemon.id,
                    context: PokemonSkillAnimatorContext(
                        sourceNode: battleFieldScene.homePokemonSpriteNode,
                        destinationNode: battleFieldScene.guestPokemonSpriteNode
                    )
                )
            )
            .run(with: currentContext)
            .then(in: .main) { context in

                self.currentContext = context

                battleFieldScene.updateData()

                self.server
                    .respond(
                        to: PlayerInvolvedRequest(playerId: self.ownerId)
                    )

            }
            .catch(in: .main) { error in

                print("\(error)")

            }
        
    }
    
}

// MARK: - BattleFieldSceneDataProvider
//
//extension PokemonBattleViewController: BattleFieldSceneDataProvider {
//
//    public final var homeBattlePokemon: BattleEntity { return currentContext.entity(id: pikachuId)! }
//
//    public final var homeBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Pikachu") }
//
//    public final var guestBattlePokemon: BattleEntity { return currentContext.entity(id: charmanderId)! }
//
//    public final var guestBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Charmander") }
//
//}

// MARK: - TurnBasedBattleServerDelegate

import TinyBattleKit

extension PokemonBattleViewController: TurnBasedBattleServerDelegate {
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        print("Server starts.")
        
        let battleFieldScene = BattleFieldScene(
            size: gameView.bounds.size
        )
        
        battleFieldScene.name = "battleScene"
        
        battleFieldScene.scaleMode = .aspectFill
        
//        battleFieldScene.sceneDataProvider = self
        
        battleFieldScene.updateData()
        
        gameView.presentScene(battleFieldScene)
        
        server.respond(
            to: ContinueBattleRequest(ownerId: server.ownerId)
        )
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) {
        
        print(
            "Server starts a turn",
            turn.id,
            currentContext
        )
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) { }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) { print("Server responds to request", request) }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) { print("\(error)") }
    
}
