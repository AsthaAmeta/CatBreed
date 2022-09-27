//
//  ListViewDataSource.swift
//  AllCats
//
//  Created by Astha Ameta on 17/09/22.
//

import Foundation
import UIKit

class ListViewDataSource<Model>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    
    private var models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model, cell)
        
        return cell
    }
}

extension ListViewDataSource where Model == Cat {
    
    static func make(for cats: [Cat],
                     reuseIdentifier: String = "CatBreedTableViewCell") -> ListViewDataSource {
        return ListViewDataSource(
            models: cats,
            reuseIdentifier: reuseIdentifier
        ) { (cat, cell) in
            if let cell = cell as? CatBreedTableViewCell, let image = cat.image, let url = URL(string: image.url) {
                cell.breedLbl.text = cat.name
                cell.originLbl.text = cat.origin
                cell.catImgView.load(url: url, placeholder: nil)
                cell.catImgView.makeRounded()
            }
        }
    }
    
}

