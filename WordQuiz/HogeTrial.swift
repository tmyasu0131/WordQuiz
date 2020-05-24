//
//  HogeTrial.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/04.
//  Copyright © 2020 tmyasu. All rights reserved.
//
import Foundation
import SwiftCop

// SwiftCop[https://github.com/andresinaka/SwiftCop]用のバリデーションクラス
public enum HogeTrial: TrialProtocol {
  case Required
  case Hiragana

    public func trial() -> ((_ evidence: String) -> Bool){
    switch self {
    case .Hiragana:
      return { (evidence: String) -> Bool in
        // 全て全角ひらがなかどうか
        let hiraganaRegEx = "^[ぁ-ゞー]+$"
        let hiraganaTest = NSPredicate(format:"SELF MATCHES %@", hiraganaRegEx)
        return hiraganaTest.evaluate(with: evidence)
      }
    default:
        return { (evidence: String) -> Bool in
            return false
        }
    }
  }
}
