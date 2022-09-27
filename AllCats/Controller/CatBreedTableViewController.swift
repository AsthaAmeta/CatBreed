//
//  CatBreedTableViewController.swift
//  AllCats
//
//  Created by Astha Ameta on 15/09/22.
//

import UIKit

class CatBreedTableViewController: UITableViewController {
    
    private let cellID = "CatBreedTableViewCell"
    private let viewModel = CatBreedViewModel()

    private var listDataSource: ListViewDataSource<Cat>?
    private var listDelegate: ListViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.delegate = self
        
        viewModel.getData {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
   
    func setupUI() {
        self.tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        listDelegate?.delegate = self
        listDelegate = ListViewDelegate(cellIdentifier: cellID, viewModel: viewModel, delegate: self)
        self.tableView.delegate = listDelegate
    }
}

extension CatBreedTableViewController: CatBreedDelegate {
    func didUpdateBreed(cat: [Cat]) {
        DispatchQueue.main.async { [self] in
            self.listDataSource = .make(for: cat)
            self.tableView.dataSource = listDataSource
        }
    }
}

extension CatBreedTableViewController: CatBreedPresentingDelegate {
    func selectedCell(cat: Cat?) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CatDetailsVC") as? CatDetailsViewController
        detailsVC?.catDetails = cat
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
}
