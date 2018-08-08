//
//  ViewController.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel : HomeViewModel = HomeViewModel()
    @IBOutlet weak var pageCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInitialData()
        updateCountLabel()
    }
}

//MARK: Table View Delegates and Data Source Methods
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : HomeCell = tableView.dequeueReusableCell(withIdentifier: Constant.ID_VC_CELL_TABLE_IDENTIFIER) as? HomeCell else{
            return UITableViewCell()
        }
        cell.userInformation = viewModel.datasource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.updateCountLabel()
        if indexPath.row == viewModel.datasource.count - 1{
            self.fetchMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = DetailViewController.instance{
            detailVC.userInformation = viewModel.datasource[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

//MARK: DATASOURCE
extension HomeViewController{
    
    func fetchInitialData(){
        if(Utility.isConnectedToNetwork()){
            Loader.shared.startLoader()
            DispatchQueue.global(qos: .background).async {
                self.viewModel.hitServiceToFetchData(forPageNo: 1) { [weak self] (success) in
                    DispatchQueue.main.async {
                        Loader.shared.stopLoader()
                        if success{
                            self?.tableView.reloadData()
                        }else if let weakself = self{
                            Utility.showError(withMessage: Constant.ERROR_FETCHING_DATA, onViewController: weakself)
                        }
                    }
                }
            }
        }else{
            Utility.showError(withMessage: Constant.INTERNET_NOT_AVAILABLE_ERROR_MESSAGE, onViewController: self)
        }
    }
    
    func fetchMoreData(){
        if let currentPage = viewModel.results?.page{
            DispatchQueue.global(qos: .background).async {
                self.viewModel.hitServiceToFetchData(forPageNo: currentPage+1) { [weak self] (success) in
                    DispatchQueue.main.async {
                        if success{
                            if let currentDataCount = self?.tableView.numberOfRows(inSection: 0),let newDataCount = self?.viewModel.datasource.count, currentDataCount < newDataCount{
                                var indexPathsToInsert : [IndexPath] = [IndexPath]()
                                for i in currentDataCount..<newDataCount{
                                    indexPathsToInsert.append(IndexPath.init(row: i, section: 0))
                                }
                                self?.tableView.beginUpdates()
                                self?.tableView.insertRows(at: indexPathsToInsert, with: .automatic)
                                self?.tableView.endUpdates()
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: UI
extension HomeViewController{
    
    func updateCountLabel(){
        let firstVisibleRow : Int = self.tableView.indexPathsForVisibleRows?.first?.row ?? 0
        self.pageCountLabel.text = viewModel.getCountLabelText(forFirstRow: firstVisibleRow)
    }
}

