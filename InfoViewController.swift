//
//  InfoViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/27/18.
//  Copyright © 2018 Sanoma MDC. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var infoTableView: UITableView!
    
    let headerArray = ["InfoScreen_GameRandomColor".localized(),
                       "InfoScreen_GameHajime".localized()]
    
    let contentArray = ["InfoScreen_GameRandomColorDescription".localized(),
                        "InfoScreen_GameHajimeDescription".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        infoTableView.allowsSelection = false
        infoTableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    func setUpView() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("CustomInfoHeaderTableViewCell",
                                                  owner: self,
                                                  options: nil)?.first as? CustomInfoHeaderTableViewCell
        headerView?.headerInfoTitle.text = headerArray[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let customCell = Bundle.main.loadNibNamed("CustomInfoTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? CustomInfoTableViewCell {
            customCell.descriptionLabel.text = contentArray[indexPath.section]
            cell = customCell
        }
        return cell
    }
    
    
}
