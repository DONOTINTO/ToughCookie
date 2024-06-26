//
//  TickerMainSectionHeaderView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/23/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift

class TickerMainSectionHeaderView: UITableViewHeaderFooterView {
    
    let titleLanguageButton = UIButton()
    let tradePriceButton = UIButton()
    let changeButton = UIButton()
    let accTradePriceButton = UIButton()
    
    var disposeBag = DisposeBag()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        
        layout()
    }
    
    func layout() {
        
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        contentView.pin.width(size.width)
        
        layout()
        
        return contentView.frame.size
    }
    
    func configure() {
        
        contentView.flex.direction(.column).define { flex in
            
            flex.addItem().direction(.row).paddingHorizontal(2.5%).justifyContent(.spaceBetween).marginTop(5).define { flex in
                
                flex.addItem()
                    .width(30%)
                    .direction(.row).define { flex in
                        
                        flex.addItem(titleLanguageButton)
                    }
                
                flex.addItem(tradePriceButton)
                    .width(25%)
                    .alignContent(.end)
                
                flex.addItem(changeButton)
                    .width(20%)
                
                flex.addItem(accTradePriceButton)
                    .width(20%)
            }
            
            flex.addItem()
                .marginTop(5)
                .width(100%)
                .height(0.5)
                .backgroundColor(.darkGray)
        }
        
        // contentView.
        
        contentView.backgroundColor = .white
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 8)
        titleLanguageButton.sectionTitleButtion(title: "한글명",
                                                image: UIImage(systemName: "arrow.left.arrow.right",
                                                               withConfiguration: imageConfiguration),
                                                color: .black)
        
        tradePriceButton.sectionTitleButtion(title: "현재가",
                                             image: UIImage(systemName: "arrow.up",
                                                            withConfiguration: imageConfiguration),
                                             color: .black)
        
        changeButton.sectionTitleButtion(title: "전일대비",
                                         image: UIImage(systemName: "arrow.up",
                                                        withConfiguration: imageConfiguration),
                                         color: .black)
        
        accTradePriceButton.sectionTitleButtion(title: "누적대금",
                                                image: UIImage(systemName: "arrow.up",
                                                               withConfiguration: imageConfiguration),
                                                color: .black)
    }
    
    func updateTitleLanguage() {
        
        let curLanguageType = CoinRepository.shared.languageType
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 8)
        titleLanguageButton.sectionTitleButtion(title: curLanguageType == .korean ? "한글명" : "영문명",
                                                image: UIImage(systemName: "arrow.left.arrow.right",
                                                               withConfiguration: imageConfiguration),
                                                color: .black)
    }
    
    func updateSortedType() {
        
        let curSortedType = CoinRepository.shared.sortedType
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 8)
        
        switch curSortedType {
        case .tradePrice, .tradePriceASC, .tradePriceDESC:
            
            tradePriceButton.sectionTitleButtion(title: curSortedType.title,
                                                 image: UIImage(systemName: curSortedType.imageName,
                                                                withConfiguration: imageConfiguration),
                                                 color: curSortedType.color)
            
            changeButton.sectionTitleButtion(title: "전일대비",
                                             image: UIImage(systemName: "arrow.up",
                                                            withConfiguration: imageConfiguration),
                                             color: .black)
            
            accTradePriceButton.sectionTitleButtion(title: "누적대금",
                                                    image: UIImage(systemName: "arrow.up",
                                                                   withConfiguration: imageConfiguration),
                                                    color: .black)
            
        case .change, .changeASC, .changeDESC:
            
            tradePriceButton.sectionTitleButtion(title: "현재가",
                                                 image: UIImage(systemName: "arrow.up",
                                                                withConfiguration: imageConfiguration),
                                                 color: .black)
            
            changeButton.sectionTitleButtion(title: curSortedType.title,
                                                 image: UIImage(systemName: curSortedType.imageName,
                                                                withConfiguration: imageConfiguration),
                                                 color: curSortedType.color)
            
            accTradePriceButton.sectionTitleButtion(title: "누적대금",
                                                    image: UIImage(systemName: "arrow.up",
                                                                   withConfiguration: imageConfiguration),
                                                    color: .black)
            
        case .accTradePrice, .accTradePriceASC, .accTradePriceDESC:
            
            tradePriceButton.sectionTitleButtion(title: "현재가",
                                                 image: UIImage(systemName: "arrow.up",
                                                                withConfiguration: imageConfiguration),
                                                 color: .black)
            
            changeButton.sectionTitleButtion(title: "전일대비",
                                             image: UIImage(systemName: "arrow.up",
                                                            withConfiguration: imageConfiguration),
                                             color: .black)
            
            accTradePriceButton.sectionTitleButtion(title: curSortedType.title,
                                                 image: UIImage(systemName: curSortedType.imageName,
                                                                withConfiguration: imageConfiguration),
                                                 color: curSortedType.color)
            
        default:
            print("1")
        }
        
    }
}
