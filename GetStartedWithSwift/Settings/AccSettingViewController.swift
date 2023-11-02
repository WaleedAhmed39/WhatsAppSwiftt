//
//  AccSettingViewController.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 12/7/2023.
//

import UIKit


class AccSettingViewController: UITableViewController {
    
    
    private var viewModel = AccSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "AccSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "AccSettingTableViewCell")
        
        tableView.estimatedRowHeight = 74
        tableView.rowHeight = UITableView.automaticDimension
       
        tableView.delegate = self
        tableView.dataSource = self
        
//        let searchController = UISearchController(searchResultsController: nil)
//
//        searchController.searchBar.showsCancelButton = true
//
//        if let button = searchController.cancelButton() {
//            // Customize button
//            let iconImage = UIImage(named: "info_icon")
//            button.isEnabled = true
//            button.setTitle("", for: .normal)
//            button.setBackgroundImage(iconImage, for: .normal)
//            button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        }
//
//        self.chatNavtigationItem.searchController = searchController
    }
   

}


extension AccSettingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.accsetting.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccSettingTableViewCell", for: indexPath) as! AccSettingTableViewCell
        
        cell.accsetting = self.viewModel.accsetting[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
