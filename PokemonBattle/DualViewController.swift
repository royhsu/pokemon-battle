//
//  DualViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - DualViewController

import UIKit

public final class DualViewController: UIViewController {
    
    // MARK: Property
    
    private final let topViewController: UIViewController
    
    private final let bottomViewController: UIViewController
    
    // MARK: Init
    
    public init(
        topViewController: UIViewController,
        bottomViewController: UIViewController
    ) {
        
        self.topViewController = topViewController
        
        self.bottomViewController = bottomViewController
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let topView = topViewController.view!
        
        topView.transform = .init(rotationAngle: .pi)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        addChildViewController(topViewController)
        
        view.addSubview(topView)
        
        let bottomView = bottomViewController.view!
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addChildViewController(bottomViewController)
        
        view.addSubview(bottomView)
        
        let separatorView = UIView()
        
        separatorView.backgroundColor = .black
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(separatorView)
        
        // Top

        topView
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true

        topView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true

        topView
            .topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        
        // Bottom
        
        bottomView
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        
        bottomView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        
        bottomView
            .bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
        // Separator
        
        separatorView
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        
        separatorView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        
        separatorView
            .topAnchor
            .constraint(equalTo: topView.bottomAnchor)
            .isActive = true
        
        separatorView
            .bottomAnchor
            .constraint(equalTo: bottomView.topAnchor)
            .isActive = true
        
        separatorView
            .heightAnchor
            .constraint(equalToConstant: 1.0)
            .isActive = true
        
        topView
            .heightAnchor
            .constraint(equalTo: bottomView.heightAnchor)
            .isActive = true
        
        topViewController.didMove(toParentViewController: self)
        
        bottomViewController.didMove(toParentViewController: self)
    
    }
    
}
