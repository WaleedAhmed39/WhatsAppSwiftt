//
//  SettingViewController.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 3/7/2023.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
 
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self , forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table } ()
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 74
    
    }
    
    func configure() {
       
        models.append(Section(title: "", options: [SettingsOption(title: "Parker David" , icon: UIImage(named:"dummy_user_1"), iconBackgroundColor: .systemBackground){
        },
        ]))
        models.append(Section(title: "", options: [SettingsOption(title: "Starred Messages", icon: UIImage(named: "star_icon"), iconBackgroundColor: .systemYellow){
            },
          SettingsOption(title: "WhatsApp Web/Desktop", icon: UIImage(named:"desk_icon"), iconBackgroundColor: .systemGreen){
             }
        ]))
      
        models.append(Section(title: "", options: [SettingsOption(title: "Account",  icon: UIImage(named:"acc_icon"), iconBackgroundColor: .systemBlue){
        },
         SettingsOption(title: "Chat",  icon: UIImage(named:"whatsapp_icon1"), iconBackgroundColor: .systemGreen){
                                                          },
         SettingsOption(title: "Notifications",  icon: UIImage(named:"noti_icon"), iconBackgroundColor: .systemPink){
        },
         SettingsOption(title: "Data and Storage Usage",  icon: UIImage(named:"data_icon"), iconBackgroundColor: .systemGreen){
        }
        ]))
       
        models.append(Section(title: "", options: [SettingsOption(title: "Help", icon: UIImage(named:"help_icon"), iconBackgroundColor: .systemBlue){
        },
         SettingsOption(title: "Tell a Friend", icon: UIImage(named:"tell_icon"), iconBackgroundColor: .systemRed){
        }   ]))
    }
    
    func tableView(_ tableView:UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier , for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 84
        } else {
            return UITableView.automaticDimension
        }
    }
}
