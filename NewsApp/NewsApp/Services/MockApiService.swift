//
//  MocApiService.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class MockApiService: RemoteNewsService {
    var delegate: NewsRemoteServiceDelegate?
    let newsData: [[String : AnyObject]] = [["author":"Satoshi Nakaboto","title":"Satoshi Nakaboto: ‘Bitcoin drops another 3% as stock markets continue to fall’","description":"Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Sloterdijk used to say: Your imagination i…","url":"https://thenextweb.com/hardfork/2020/09/24/satoshi-nakaboto-bitcoin-drops-another-3-as-stock-markets-continue-to-fall/","urlToImage":"https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864","publishedAt":"2020-09-24T08:32:32Z","content":"Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\r\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in"], ["author":"Sandali Handagama","title":"Iran Is Ripe for Bitcoin Adoption, Even as Government Clamps Down on Mining","description":"Iran is regulating bitcoin mining with an iron fist. But as U.S. sanctions and the pandemic put pressure on the economy, Iranians are seriously considering bitcoin as an alternative to the falling rial.","url":"https://www.coindesk.com/iran-is-ripe-for-bitcoin-adoption-even-as-government-clamps-down-on-mining","urlToImage":"https://static.coindesk.com/wp-content/uploads/2020/09/36350085066_0187917c70_o-1-scaled.jpg","publishedAt":"2020-09-24T08:11:52Z","content":"Iran-based bitcoiner Zahra Amini was used to answering questions on cryptocurrencies, but usually about their relationship with crime. So when a 70-year-old man recently asked her to explain crypto b…"]] as [[String : AnyObject]]
    
    func loadNews(page: Int) {
        delegate?.didLoadData(newsData)
    }
}
