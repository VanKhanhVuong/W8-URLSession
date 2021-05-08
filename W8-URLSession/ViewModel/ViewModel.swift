//
//  ViewModel.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 05/05/2021.
//

import Foundation

protocol ViewModelEvents: class {
    func gotData()
    func gotError(message: ErrorResponse)
}

class ViewModel {
    weak var delegate: ViewModelEvents?
    private var apiService = QueryService()
    var arrayDrink: [DrinkItem] = []
    
    func gotDataFromApi(searchString: String) {
        self.arrayDrink = []
        apiService.getSearchResults(searchTerm: searchString) { [weak self] result, error  in
            if searchString.isEmpty {
                self?.arrayDrink = []
                self?.delegate?.gotData()
                return
            }
            guard let self = self else { return }
            if let resultData = result {
                if !resultData.isEmpty {
                    resultData.forEach { (drink) in
                        self.arrayDrink.append(drink)
                    }
                    self.delegate?.gotData()
                }
            } else {
                guard let errorMessage = error else { return }
                self.delegate?.gotError(message: errorMessage)
            }
        }
    }
    
    func gotDataEmpty() {
        self.arrayDrink.removeAll()
    }
}

//switch result {
//case .success(let arrayResult):
//    arrayResult.forEach { (drink) in
//        self.arrayDrink.append(drink)
//    }
//    self.delegate?.gotData()
//    break
//case .failure(let error):
//    //self.delegate?.gotError(message: error)
//    break
