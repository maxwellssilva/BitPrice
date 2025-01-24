//
//  ViewController.swift
//  BitPrice
//
//  Created by Maxwell Silva on 23/01/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = URL(string: "https://www.blockchain.com/pt/ticker") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error == nil {
                    print("Sucesso! URL funcionando corretamente")
                    if let dataReturn = data {
                        do {
                            if let objectJson = try JSONSerialization.jsonObject(with: dataReturn, options: [])
                                as? [String: Any] {
                                if let brl = objectJson["BRL"] as? [String: Any] {
                                    if let buyBitcoin = brl["buy"] as? Double {
                                        print(buyBitcoin)
                                    }
                                }
                                //print(objectJson)
                            }
                        } catch {
                            print("Erro ao formatar o objeto JSON")
                        }
                    }
                } else {
                    print("Erro ao consultar a URL")
                }
            }
            task.resume()
        }
    }
}

