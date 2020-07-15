//
//  DateExtension.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension Date {

    var today: Date {
        return rewindDays(0)
    }

    func rewindDays (_ days:Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
