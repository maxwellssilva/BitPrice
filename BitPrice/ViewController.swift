//
//  ViewController.swift
//  BitPrice
//
//  Created by Maxwell Silva on 23/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, numberLabel, updateButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bitcoin")
        image.heightAnchor.constraint(equalToConstant: 90).isActive = true
        image.widthAnchor.constraint(equalToConstant: 90).isActive = true
        return image
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "R$0,00"
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        label.textColor = .systemOrange
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Atualizar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        
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
    
    func setupLayout() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
        ])
    }
}

