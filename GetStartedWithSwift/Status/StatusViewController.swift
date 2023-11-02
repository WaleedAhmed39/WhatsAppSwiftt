//
//  StatusViewController.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 26/6/2023.
//

import UIKit

class StatusViewController: UITableViewController {
    
    @IBOutlet weak var StatusNavtigationItem: UINavigationItem!
    
    private var viewModel = StatusViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusTableViewCell")
        tableView.register(UINib(nibName: "FurtherStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "FurtherStatusTableViewCell")
        
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

extension StatusViewController{

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.status.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath) as! StatusTableViewCell
            cell.status = self.viewModel.status[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FurtherStatusTableViewCell", for: indexPath) as! FurtherStatusTableViewCell
            return cell
        }
    }
    
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 74
        }
    }
