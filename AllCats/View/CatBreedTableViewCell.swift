//
//  CatBreedTableViewCell.swift
//  AllCats
//
//  Created by Astha Ameta on 15/09/22.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

class CatBreedTableViewCell: UITableViewCell {

    @IBOutlet weak var catImgView: UIImageView!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
