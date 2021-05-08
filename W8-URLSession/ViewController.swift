//
//  ViewController.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 04/05/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var drinkSearchBar: UISearchBar!
    @IBOutlet weak var drinkTableView: UITableView!
    @IBOutlet weak var loadIndicatorView: UIActivityIndicatorView!
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        drinkSearchBar.delegate = self
        drinkTableView.delegate = self
        drinkTableView.dataSource = self
        viewModel.delegate = self
        loadIndicatorView.hidesWhenStopped = true
        stopLoadIndicatorView()
        drinkTableView.register(DrinkTableViewCell.nib(), forCellReuseIdentifier: DrinkTableViewCell.identifier())
    }
    
    private func stopLoadIndicatorView(){
        loadIndicatorView.stopAnimating()
        loadIndicatorView.frame.size.height = 0.0
    }
    
    private func startLoadIndicatorView(){
        loadIndicatorView.frame.size.height = 54.0
        loadIndicatorView.startAnimating()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Message !!!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (alert: UIAlertAction!) in
                self.drinkSearchBar.text = ""
                self.stopLoadIndicatorView()
            }
        ))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.arrayDrink.isEmpty  {
            return viewModel.arrayDrink.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.identifier(), for: indexPath) as? DrinkTableViewCell else { return UITableViewCell() }
        if !viewModel.arrayDrink.isEmpty {
            let item = viewModel.arrayDrink[indexPath.row]
            cell.tag = indexPath.row
            cell.configure(item: item, index: indexPath.row)
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 1)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        startLoadIndicatorView()
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            stopLoadIndicatorView()
            drinkTableView.rowHeight = 0
            drinkTableView.reloadData()
            return
        }
        viewModel.gotDataFromApi(searchString: query)
    }
}

extension ViewController: ViewModelEvents {
    func gotError(message: ErrorResponse) {
        DispatchQueue.main.async {
            self.showAlert(message: message.rawValue)
        }
    }
    func gotData() {
        DispatchQueue.main.async {
            self.drinkTableView.reloadData()
            self.stopLoadIndicatorView()
        }
    }
}
