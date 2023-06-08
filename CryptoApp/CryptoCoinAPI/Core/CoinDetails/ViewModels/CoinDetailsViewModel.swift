import SwiftUI

class CoinDetailsViewModel {
    
    private let coin: Coin
    
    // chart config
    var chartData = [ChartData]()
    var startDate = Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var coinName: String {
        return coin.name
    }
    
    var chartLineColor: Color {
        let priceChange = (coin.sparklineIn7D?.price.last ?? 0) - (coin.sparklineIn7D?.price.first ?? 0)
        return priceChange > 0 ? .green : .red
    }
    
    var overviewSectionModel: CoinDetailSectionModel {
        // price stats
        let price = coin.currentPrice.toCurrency()
        let pricePercentageChange = coin.priceChangePercentage24H
        let priceStats = StatisticModel(title: "Current Price",
                                        value: price,
                                        percentageChange: pricePercentageChange)
        
        // market cap stats
        let marketCap = coin.marketCap ?? 0
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization",
                                           value: marketCap.formattedWithAbbreviations(),
                                           percentageChange: marketCapPercentChange)
        
        // rank stats
        let rank = coin.marketCapRank
        let rankStat = StatisticModel(title: "Rank",
                                      value: "\(rank)",
                                      percentageChange: nil)
        
        // volume stats
        let volume = coin.totalVolume ?? 0
        let volumeStat = StatisticModel(title: "Volume",
                                        value: volume.formattedWithAbbreviations(),
                                        percentageChange: nil)
        
        return CoinDetailSectionModel(title: "Overview",
                                      stats: [priceStats,
                                              marketCapStat,
                                              rankStat,
                                              volumeStat])
    }
    
    var additionalDetailsSectionModel: CoinDetailSectionModel {
        // 24h high
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = StatisticModel(title: "24H High",
                                      value: high,
                                      percentageChange: nil)
        
        // 24h low
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: "24H Low",
                                      value: high,
                                      percentageChange: nil)
        
        // 24h price change
        let priceChange24H = coin.priceChange24H.toCurrency()
        let percentChange24H = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Change",
                                             value: priceChange24H,
                                             percentageChange: percentChange24H)
        
        // 24h market cap change
        let marketCapChange = coin.marketCapChange24H ?? 0
        let marketCapChangePercentage = coin.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: "24H Market Cap Change",
                                        value: "€\(marketCapChange.formattedWithAbbreviations())",
                                        percentageChange: marketCapChangePercentage)
        
        return CoinDetailSectionModel(title: "Additional Details", stats: [highStat,
                                                                          lowStat,
                                                                          priceChangeStat,
                                                                          marketStat])
    }
   
            
            
    
    init(coin: Coin) {
        self.coin = coin
        configureChartData()
        
        print("DEBUG: Coin is \(self.coinName)")
    }
     
    func configureChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        // jedes array of numbers -> computes the min and max value
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        // -7 -> rückwärts 7 tage * 60min * 60sec * 24 Stunden
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        self.xAxisValues = [startDate, endDate]
        
        // looping durch priceData von hinten angefangen
        for price in priceData.reversed() {
            
            // 1 stunde rückwärts zählen 
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}

/*
 
 
 
 */
