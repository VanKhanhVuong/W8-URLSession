//
//  DrinkTableViewCell.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 05/05/2021.
//

import UIKit
protocol DrinkTableViewCellEvents: class {
    func pauseTapped(cell: UITableViewCell)
    func resumeTapped(cell: UITableViewCell)
    func downloadTapped(cell: UITableViewCell)
    func cancelTapped(cell: UITableViewCell)
}

class DrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var idDrinkLabel: UILabel!
    @IBOutlet weak var nameDrinkLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    weak var delegate: DrinkTableViewCellEvents?
    private var imageCell: UIImage = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier(), bundle: nil)
    }
    
    func configure(item: DrinkItem, index: Int) {
        self.drinkImageView.image = UIImage(named: "empty")
        self.idDrinkLabel.text = item.idDrink
        self.nameDrinkLabel.text = item.strDrink
        if item.strDrinkThumb == "" || item.strDrinkThumb == nil {
            self.drinkImageView.image = UIImage(named: "empty")
        } else {
            drinkImageView.gotImageAndCache(urlString: item.strDrinkThumb ?? ""){ [weak self] image in
                if self?.tag == index {
                    self?.drinkImageView.image = image
                }
            }
        }
    }
    @IBAction func pauseOrResumeTapped(_ sender: Any) {
        if (pauseButton.titleLabel!.text == "Pause") {
            delegate?.pauseTapped(cell: self)
        } else {
            delegate?.resumeTapped(cell: self)
        }
    }
    
    @IBAction func downloadTapped(_ sender: Any) {
        delegate?.downloadTapped(cell: self)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.cancelTapped(cell: self)
    }
}
