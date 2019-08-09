//
//  DashboardVC.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import Hero

class DashboardVC: UIViewController {
    @IBOutlet weak var dashboardTbl: UITableView!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    private var dashVM = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        dashboardTbl.delegate = self
        dashboardTbl.dataSource = self
        dashboardTbl.register(UINib(nibName: PopularTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PopularTableViewCell.identifier)
        dashboardTbl.register(UINib(nibName: DashboardTitleHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: DashboardTitleHeaderView.identifier)
        dashboardTbl.register(UINib(nibName: NoDataTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.identifier)
        dashboardTbl.register(UINib(nibName: RecentItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecentItemTableViewCell.identifier)
        dashboardTbl.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
        dashboardTbl.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
   
    
    
    @IBAction func searchTapped(_ sender: Any) {
        
        let vc = StoryboardScene.Dashboard.searchVC.instantiate()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DashboardVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            if dashVM.recentBook.count < 5 {
                if dashVM.recentBook.isEmpty {
                    return 1
                } else {
                    return dashVM.recentBook.count
                }
            } else {
                return 5
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as? PopularTableViewCell else {
                return UITableViewCell()
            }
            
            cell.popList = dashVM.popularItemList
            cell.delegate = self
            cell.sliderCollection.reloadData()
            return cell
        default:
            guard !dashVM.recentBook.isEmpty else {
                let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.identifier, for: indexPath) as! NoDataTableViewCell
                cell.selectionStyle = .none
                cell.animationView.play()
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentItemTableViewCell.identifier, for: indexPath) as? RecentItemTableViewCell else {
                return UITableViewCell()
            }
            
            cell.bookItem = dashVM.recentBook[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: DashboardTitleHeaderView.identifier) as? DashboardTitleHeaderView else {
            return UIView()
        }
        
        switch section {
        case 0:
            cell.titleString = "Popular Books"
        default:
            cell.titleString = "Recent Books"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

extension DashboardVC: PopularCellDelegate {
    func popularItemSelected(at: Int) {
        let vc = StoryboardScene.Dashboard.searchVC.instantiate()
        vc.delegate = self
        vc.isFromPopular = true
        vc.searchKeyword = dashVM.popularItemList[at].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DashboardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("")
        default:
            guard dashVM.recentBook.isEmpty else {
                
                let vc = StoryboardScene.Dashboard.bookDetailVC.instantiate()
                vc.book = dashVM.recentBook[indexPath.row]
                present(vc, animated: true)
                return
            }
            
            let vc = StoryboardScene.Dashboard.searchVC.instantiate()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DashboardVC: SearchVCDelegate {
    func onLastSearch(book: [BookItem]) {
        guard !book.isEmpty else {
            dashboardTbl.reloadData()
            return
        }
        dashVM.recentBook.removeAll()
        let sorted = book.sorted { (a, b) -> Bool in
            a.volumeInfo.description > b.volumeInfo.description
        }
        dashVM.recentBook.append(contentsOf: sorted)
        dashboardTbl.reloadData()
    }
}
