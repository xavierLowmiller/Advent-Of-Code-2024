import Foundation

infix operator ++ : AdditionPrecedence

public func ++ (a: Int, b: Int) -> Int {
  return a.concatenateDecimalDigits(in: b)
}

extension Int {
    func concatenateDecimalDigits(in other: Int) -> Int {
        let scale: Int
        switch other {
        case 0...9:
            scale = 10
        case 10...99:
            scale = 100
        case 100...999:
            scale = 1000
        case 1000...9999:
            scale = 10000
        case 10000...99999:
            scale = 100000
        case 100000...999999:
            scale = 1000000
        case 1000000...9999999:
            scale = 10000000
        case 10000000...99999999:
            scale = 100000000
        case 100000000...999999999:
            scale = 1000000000
        case 1000000000...9999999999:
            scale = 10000000000
        case 10000000000...99999999999:
            scale = 100000000000
        case 100000000000...999999999999:
            scale = 1000000000000
        case 1000000000000...9999999999999:
            scale = 10000000000000
        case 10000000000000...99999999999999:
            scale = 100000000000000
        case 100000000000000...999999999999999:
            scale = 1000000000000000
        case 1000000000000000...9999999999999999:
            scale = 10000000000000000
        case 10000000000000000...99999999999999999:
            scale = 100000000000000000
        case 100000000000000000...999999999999999999:
            scale = 1000000000000000000
        default:
          fatalError("Too big for concatenation")
        }
        return self * scale + other
    }
}
