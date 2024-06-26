//
//  MarketsTableViewCell.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/16/24.
//

import UIKit
import FlexLayout
import PinLayout

class MarketsTableViewCell: BaseTableViewCell {
    
    let coinNameLabel = UILabel()
    let codeNameLabel = UILabel()
    let tradePriceLabel = UILabel()
    let changeRateLabel = UILabel()
    let changePriceLabel = UILabel()
    let accTradePrice24Label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        [coinNameLabel, codeNameLabel, tradePriceLabel, changeRateLabel, changeRateLabel, accTradePrice24Label].forEach {
            $0.text = ""
            $0.textColor = $0 == codeNameLabel ? .darkGray : .black
            $0.layer.borderWidth = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)
        
        // 2) Layout contentView flex container
        layout()
        
        // Return the flex container new size
        return contentView.frame.size
    }
    
    override func configure() {
        
        coinNameLabel.textColor = .black
        coinNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        codeNameLabel.textColor = .darkGray
        codeNameLabel.font = .systemFont(ofSize: 11, weight: .regular)
        
        tradePriceLabel.textColor = .black
        tradePriceLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        changeRateLabel.textColor = .black
        changeRateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        changePriceLabel.textColor = .black
        changePriceLabel.font = .systemFont(ofSize: 11, weight: .regular)
        
        accTradePrice24Label.textColor = .black
        accTradePrice24Label.font = .systemFont(ofSize: 13, weight: .regular)
        
        
        backgroundColor = .clear
    }
    
    override func configureLayout() {
        
        contentView.flex.direction(.row).justifyContent(.spaceBetween).paddingHorizontal(2.5%).height(UITableView.automaticDimension).define { flex in
            
            flex.addItem()
                .direction(.column)
                .width(30%)
                .marginVertical(7)
                .define { flex in
                    
                flex.addItem(coinNameLabel)
                flex.addItem(codeNameLabel)
            }
            
            flex.addItem()
                .direction(.column)
                .alignItems(.end)
                .width(25%)
                .marginVertical(7)
                .define { flex in
                    
                flex.addItem(tradePriceLabel)
                flex.addItem().grow(1)
            }
            
            flex.addItem()
                .direction(.column)
                .alignItems(.end)
                .width(20%)
                .marginVertical(7)
                .define { flex in
                    
                flex.addItem(changeRateLabel)
                flex.addItem(changePriceLabel)
            }
            
            flex.addItem()
                .direction(.column)
                .alignItems(.end)
                .width(20%)
                .marginVertical(7)
                .define { flex in
                    
                flex.addItem(accTradePrice24Label)
                flex.addItem().grow(1)
            }
        }
    }
}

extension MarketsTableViewCell {
    
    func configureView(_ tickerPresentData: TickerPresentData) {
        
        self.selectionStyle = .none
        
        let marketData = CoinRepository.shared.getMarketDatumByTickerPresentData(tickerPresentData)
        let sign = CoinSign(rawValue: tickerPresentData.change) ?? .even
        
        let coinName = CoinRepository.shared.languageType == .korean ? marketData.koreanName : marketData.englishName
        
        coinNameLabel.text = coinName
        coinNameLabel.adjustsFontSizeToFitWidth = true
        coinNameLabel.flex.markDirty()
        
        codeNameLabel.text = tickerPresentData.code
        codeNameLabel.adjustsFontSizeToFitWidth = true
        codeNameLabel.flex.markDirty()
        
        let tradePrice = NumberUtil.changeDoubleToDecimalStr(tickerPresentData.tradePrice)
        tradePriceLabel.text = tradePrice
        tradePriceLabel.textColor = sign.color
        tradePriceLabel.adjustsFontSizeToFitWidth = true
        tradePriceLabel.flex.markDirty()
        
        let changeRate = NumberUtil.changeDecimalToPercentage(tickerPresentData.changeRate)
        changeRateLabel.text = "\(sign.sign)\(changeRate)%"
        changeRateLabel.textColor = sign.color
        changeRateLabel.adjustsFontSizeToFitWidth = true
        changeRateLabel.flex.markDirty()
        
        let changePrice = NumberUtil.changeDoubleToDecimalStr(tickerPresentData.changePrice)
        changePriceLabel.text = "\(sign.sign)\(changePrice)"
        changePriceLabel.textColor = sign.color
        changePriceLabel.adjustsFontSizeToFitWidth = true
        changePriceLabel.flex.markDirty()
        
        let accTradePrice24H = NumberUtil.changeDoubleToOneMillionStr(tickerPresentData.accTradePrice24H)
        accTradePrice24Label.text = "\(accTradePrice24H)"
        accTradePrice24Label.adjustsFontSizeToFitWidth = true
        accTradePrice24Label.flex.markDirty()
    }
    
    func updateSign(_ tickerPresentData: TickerPresentData) {
        
        if tickerPresentData.updateTradePriceSign == .even { return }
        
        tradePriceLabel.layer.borderWidth = 1
        tradePriceLabel.layer.borderColor = tickerPresentData.updateTradePriceSign.color.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            
            guard let self else { return }
            
            self.tradePriceLabel.layer.borderWidth = 0
        }
    }
}
