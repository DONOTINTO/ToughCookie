//
//  MarketsView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit
import FlexLayout
import PinLayout

class MarketsView: BaseView {
    
    let tableView = UITableView()
    
    override func configureView() {
        
        flexView.backgroundColor = .white
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray.withAlphaComponent(0.3)
        tableView.separatorInset = .zero
        tableView.bounces = false
        
        addSubview(tableView)
        
        flexView.flex.define { flex in
            
            flex.addItem(tableView).grow(1)
        }
    }
}

