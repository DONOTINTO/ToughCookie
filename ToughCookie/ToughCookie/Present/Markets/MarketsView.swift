//
//  MarketsView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit

class MarketsView: BaseView {
    
    let tableView = UITableView()
    
    override func configureView() {
        
        tableView.backgroundColor = .clear
        
        addSubview(tableView)
        
        flexView.flex.define { flex in
            flex.addItem(tableView).grow(1)
        }
    }
}
