//
//  BaseView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/14/24.
//

import UIKit
import FlexLayout
import PinLayout

class BaseView: UIView {

    let flexView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(flexView)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flexView.pin.all(self.pin.safeArea)
        flexView.flex.layout()
    }
    
    func configureView() { }
}
