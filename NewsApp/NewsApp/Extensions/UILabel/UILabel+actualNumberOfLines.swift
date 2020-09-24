//
//  UILabel+Extension.swift
//  NewsApp
//
//  Created by Артем  on 7/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

extension UILabel {
  func actualNumberOfLines() -> Int {
    self.layoutIfNeeded()
    guard let myText = self.text as NSString? else { return 0 }
    let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
    return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
  }
}
