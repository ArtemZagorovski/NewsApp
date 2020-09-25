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
    let newsData: [[String : AnyObject]] =
        [
            [
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin drops another 3% as stock markets continue to fall’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Sloterdijk used to say: Your imagination i…",
                "url": "https://thenextweb.com/hardfork/2020/09/24/satoshi-nakaboto-bitcoin-drops-another-3-as-stock-markets-continue-to-fall/",
                "publishedAt": "2020-09-24T08:32:32Z"
            ],
            [
                "author": "Sandali Handagama",
                "title": "Iran Is Ripe for Bitcoin Adoption, Even as Government Clamps Down on Mining",
                "description": "Iran is regulating bitcoin mining with an iron fist. But as U.S. sanctions and the pandemic put pressure on the economy, Iranians are seriously considering bitcoin as an alternative to the falling rial.",
                "url": "https://www.coindesk.com/iran-is-ripe-for-bitcoin-adoption-even-as-government-clamps-down-on-mining",
                "publishedAt": "2020-09-24T08:11:52Z"
            ]
        ] as [[String : AnyObject]]
    
    func loadNews(page: Int) {
        delegate?.didLoadData(newsData)
    }
}
