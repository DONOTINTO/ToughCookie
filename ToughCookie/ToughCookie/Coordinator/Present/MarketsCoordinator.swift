//
//  MarketsCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol MarketsCoordinatorProtocol: Coordinator {
    
    var marketAllData: [FetchMarketAllData] { get set }
    
    func showMarketsTabView()
}

class MarketsCoordinator: MarketsCoordinatorProtocol {
    
    var coordinatorType: CoordinatorType { .markets }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var marketAllData: [FetchMarketAllData] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit - marketsCoordinator")
    }
}

extension MarketsCoordinator {
    
    func start() {
        showMarketsTabView()
    }
    
    func showMarketsTabView() {
        
        guard !marketAllData.isEmpty else { return }
        
        let marketsViewModel = MarketsViewModel(coordinator: self, data: marketAllData)
        let marketsViewController = MarketsViewController(viewModel: marketsViewModel)
        
        self.navigationController.pushViewController(marketsViewController, animated: false)
        
        self.navigationController.navigationBar.topItem?.title = coordinatorType.title
    }
}

extension MarketsCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        
        self.childCoordinators = self.childCoordinators.filter { $0.coordinatorType != childCoordinator.coordinatorType }
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}