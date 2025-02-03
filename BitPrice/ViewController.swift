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
        label.numberOfLines = 0
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
        view.backgroundColor = .white
        setupLayout()
        loadPrice()
    }
    
    func recoverPrice() {
        updateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        loadPrice()
    }
    
    func formatPrice(price: NSNumber) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        if let finalPrice = numberFormatter.string(from: price) {
            return finalPrice
        }
        return "0,00"
    }
    
    func loadPrice() {
        self.updateButton.setTitle("Atualizando", for: .normal)
        
        guard let url = URL(string: "https://www.blockchain.com/pt/ticker") else {
            print("Erro: URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Erro ao consultar a URL: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Erro: Nenhum dado retornado")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonObject = try decoder.decode(TickerResponse.self, from: data)
                let priceFormat = self?.formatPrice(price: NSNumber(value: jsonObject.BRL.buy))
                
                DispatchQueue.main.async {
                    self?.numberLabel.text = "R$\(priceFormat)"
                    self?.updateButton.setTitle("Atualizar", for: .normal)
                }
            } catch {
                print("Erro de decodificação do JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func setupLayout() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
        ])
    }
}
