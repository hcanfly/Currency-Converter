//
//  ViewController.swift
//  Currency Converter
//
//  Created by Gary on 4/22/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit

let defaultCurrency = "USD"


final class CurrencyViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var rates: [ExchangeRate]?
    private var baseCurrency = defaultCurrency
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        
        self.displayBaseCurrency(country: self.baseCurrency)
        
        self.initializeCollectionVew()

        self.setupConstraints()

        self.getExchangeRates(for: defaultCurrency)
    }

    private func getExchangeRates(for currency: String) {
        getExchangeValues(for: currency, myType: Rates.self) { [weak self] exchangeRates in
            if let self = self {
                self.rates = [ExchangeRate]()
                for (k,v) in exchangeRates.rates {
                    self.rates!.append(ExchangeRate(currency: k,rate: v))
                }
                self.rates!.sort(by: {$0.currency < $1.currency})
                self.baseCurrency = exchangeRates.base
                self.displayBaseCurrency(country: self.baseCurrency)
                UIView.transition(with: self.collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: { self.collectionView.reloadData() }, completion: nil)
            }
        }
    }

    private func displayBaseCurrency(country: String) {
        let label = UILabel()

        label.text = "Exchange rates for: \(formattedRate(for: country, rate: 1.0)) \(emojiFlag(country))"
        label.textColor = .label
        self.navigationItem.titleView = label
    }

}

// MARK: Initialization
extension CurrencyViewController {

    private func initializeCollectionVew() {
        var collectionViewFrame = self.view.bounds

        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            collectionViewFrame = safeFrame
        }

        self.collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: createLayout())
        self.collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier)
         self.collectionView.backgroundColor = .systemBackground
         self.collectionView.delegate = self
         self.collectionView.dataSource = self
         self.view.addSubview(self.collectionView)
     }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
                
        return layout
    }
    
    private func setupConstraints() {
         let edgeInsets = self.view.safeAreaInsets

         self.collectionView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
         self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: edgeInsets.left),
         self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
         self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: edgeInsets.bottom),
         self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: edgeInsets.right)
         ])
     }
}

extension CurrencyViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        let rate = self.rates![indexPath.row]

        getExchangeRates(for: rate.currency)
    }
    
}

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.rates == nil ? 0 : self.rates!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrencyCollectionViewCell else {
            fatalError("Failed to dequeue a CurrencyCollectionViewCell.")
        }

        let countryCode = self.rates![indexPath.row].currency
        cell.countryNameLabel.text = countryNames[countryCode]
        cell.flagLabel.text = emojiFlag(countryCode)
        cell.currencyText = formattedRate(for: countryCode, rate: self.rates![indexPath.row].rate)

        return cell
    }

}

extension CurrencyViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.bounds.width - 20, height: 80)
    }
}
