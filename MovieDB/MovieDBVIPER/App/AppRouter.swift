//
//  AppRouter.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let viewController = MoviesBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
