//
//  ListViewDelegate.swift
//  AllCats
//
//  Created by Astha Ameta on 17/09/22.
//

import Foundation
import UIKit

protocol CatBreedPresentingDelegate {
    func selectedCell(cat: Cat?)
}

class ListViewDelegate: NSObject, UITableViewDelegate {
    var delegate: CatBreedPresentingDelegate?
    
    let cellIdentifier: String
    let viewModel: CatBreedViewModel
    
    init(cellIdentifier: String, viewModel: CatBreedViewModel, delegate: CatBreedPresentingDelegate) {
        self.cellIdentifier = cellIdentifier
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentVal = viewModel.cat[indexPath.row]
        delegate?.selectedCell(cat: currentVal)
    }
}
