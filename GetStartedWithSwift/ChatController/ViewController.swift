//
//  ViewController.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 21/06/2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatNavtigationItem: UINavigationItem!
    
    private var viewModel = TabChatViewModel()
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        
        chatTableView.estimatedRowHeight = 74
        chatTableView.rowHeight = UITableView.automaticDimension
       
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rand = Int.random(in: 0..<viewModel.conversations.count)
        viewModel.conversations[rand].unreadCount = Int.random(in: 0...100)
        self.chatTableView.reloadRows(at: [IndexPath(row: rand, section: 0)], with: .none)
    }

}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        cell.conversation = self.viewModel.conversations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatThreadedViewController") as! ChatThreadedViewController
        vc.viewModel = ThreadedViewModel()
        vc.viewModel.conversation = self.viewModel.conversations[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
