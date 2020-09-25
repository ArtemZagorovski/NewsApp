//
//  DateExtension.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension Date {
    func rewindDays (_ days: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: days, to: self) else { return Date() }
        return date
    }
}
