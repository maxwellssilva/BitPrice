import UIKit
import Foundation

//var numero = "2.003,15"
//
//let numberFormater = NumberFormatter()
////numberFormater.decimalSeparator = ","
//numberFormater.numberStyle = .decimal
//numberFormater.locale = .init(identifier: "pt_BR")
//
//if let resultadoNumeroFormatado = numberFormater.number(from: numero) {
//    let resultadoDouble = Double(truncating: resultadoNumeroFormatado)
//    let total = resultadoDouble + 1
//    print(resultadoNumeroFormatado)
//}
//--------------------------------------------------

// Segundo exemplo

let numero = NSNumber(value: 1000.20)
let nf = NumberFormatter()
nf.numberStyle = .decimal
//nf.groupingSeparator = "."
//nf.decimalSeparator = ","
nf.locale = Locale(identifier: "pt_BR")

if let resultado = nf.string(from: numero) {
    print(resultado)
}
