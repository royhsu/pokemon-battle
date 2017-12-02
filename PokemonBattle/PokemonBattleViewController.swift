//
//  PokemonBattleViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleViewController

import RealmSwift
import UIKit

public final class PokemonBattleViewController: UIViewController {
    
    // MARK: Property
    
    private final var server: TurnBasedBattleServer!
    
    private final let system = BattleSystem()
    
    private final let serverDataProvider = RealmServerDataProvider()
    
    // MARK: Init
    
    public init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    // MARK: View Life Cycle
    
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
        
        let ownerId = UUID().uuidString
        
        let recordId = UUID().uuidString
        
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
        
        server.resume()
        
    }
    
    // MARK: Action
    
    @objc public final func selectSkill(_ sender: Any) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

import TinyBattleKit

extension PokemonBattleViewController: TurnBasedBattleServerDelegate {
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        server.respond(
            to: ContinueBattleRequest(ownerId: server.ownerId)
        )
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) {
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
    }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) { print("\(error)") }
    
}
