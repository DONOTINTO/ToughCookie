//
//  AppCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    
    func showTabFlow(_ data: [MarketData])
    func showLaunchFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var coordinatorType: CoordinatorType { .app }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate? = nil
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator {
    
    func start() {
        self.showLaunchFlow()
    }
    
    func showTabFlow(_ data: [MarketData]) {
        
        let tabBarCoordinator = TabCoordinator(navigationController)
        tabBarCoordinator.marketAllData = data
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        
        childCoordinators.append(tabBarCoordinator)
    }
    
    func showLaunchFlow() {
        
        let launchCoordinator = LaunchCoordinator(navigationController)
        launchCoordinator.finishDelegate = self
        launchCoordinator.start()
        
        childCoordinators.append(launchCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
        childCoordinators = childCoordinators.filter {
            $0.coordinatorType != childCoordinator.coordinatorType
        }
        
        switch childCoordinator.coordinatorType {
            
        case .launch:
            
            guard let launchCoordinator = childCoordinator as? LaunchCoordinator else { return }
            
            let data = launchCoordinator.marketAllData
            
            navigationController.viewControllers.removeAll()
            showTabFlow(data)
            
        default: return
        }
    }
}
