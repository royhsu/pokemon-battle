//
//  ParallelViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - ParallelViewController

import UIKit

public final class ParallelViewController: UIViewController {
    
    // MARK: Property
    
    private final let leftViewController: UIViewController
    
    private final let rightViewController: UIViewController
    
    // MARK: Init
    
    public init(
        leftViewController: UIViewController,
        rightViewController: UIViewController
    ) {
        
        self.leftViewController = leftViewController
        
        self.rightViewController = rightViewController
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Left
        
        addChildViewController(leftViewController)
        
        let leftView = leftViewController.view!
        
        leftView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftView)
        
        leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        leftView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Right
        
        addChildViewController(rightViewController)

        let rightView = rightViewController.view!

        rightView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(rightView)

        rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        rightView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        rightView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Separator
        
        let separatorView = UIView()
        
        separatorView.backgroundColor = .black
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(separatorView)
        
        separatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        separatorView.widthAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        
        separatorView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        
        leftView.widthAnchor.constraint(equalTo: rightView.widthAnchor).isActive = true
        
        leftViewController.didMove(toParentViewController: self)
        
        rightViewController.didMove(toParentViewController: self)
    
    }
    
}
