//
//  CoinView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject
    var viewModel: CoinViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            marketDataView(viewModel: viewModel)
            Divider()
                .background(Color.white)
            TickerView(askOrderBook: viewModel.askOrderBook, bidOrderBook: viewModel.bidOrderBook)
            
        }
        .task {
            viewModel.connect()
        }
        .onAppear {
            viewModel.connect()
        }
        .onDisappear {
            viewModel.disconnect()
        }
        .background(Color.subBlue)
    }
    
    //  마켓 데이터 뷰
    func marketDataView(viewModel: CoinViewModel) -> some View {
        
        let sign = CoinSign(rawValue: viewModel.updateTickerData.change) ?? .even
        let signColor: Color
        let changeImage: String
        switch sign {
        case .rise:
            signColor = Color.red
            changeImage = "arrowtriangle.up.fill"
        case .even:
            signColor = Color.white
            changeImage = ""
        case .fall:
            signColor = Color.blue
            changeImage = "arrowtriangle.down.fill"
        }
        
        let changeRate = NumberUtil.changeDecimalToPercentage(viewModel.updateTickerData.changeRate)
        let changePrice = NumberUtil.changeDoubleToDecimalStr(viewModel.updateTickerData.changePrice)
        
        
        return HStack {
            VStack(alignment: .leading) {
                Text(viewModel.updateTickerData.tradePrice.formatted())
                    .asDefaultText(fontSize: 15, textColor: signColor)
                
                HStack(spacing: 5) {
                    Text("\(sign.sign)\(changeRate)%")
                        .asDefaultText(fontSize: 13, textColor: signColor)
                    Spacer().frame(width: 10)
                    
                    Image(systemName: changeImage)
                        .resizable()
                        .foregroundStyle(signColor)
                        .frame(width: 10, height: 10)
                        
                    Text("\(changePrice)")
                        .asDefaultText(fontSize: 13, textColor: signColor)
                }
            }.padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 0))
            
            Spacer()
        }
    }
}
