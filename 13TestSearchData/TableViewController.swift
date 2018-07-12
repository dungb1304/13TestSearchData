//
//  TableViewController.swift
//  SearchDemoCode
//
//  Created by Ngọc Anh on 5/26/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate{
    
    
    var list = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = list
        
        // xac dinh moi khi o text trong search bar thay doi
        searchController.searchResultsUpdater = self
        
        // set false giup table view khong bi che khuat
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        
        // hien thi search bar o table view header
        tableView.tableHeaderView = searchController.searchBar
        
        //set bang true de search bar khong bi loi layout khi chay ung dung
        definesPresentationContext = true
        
        // chinh giao dien thanh search bar
        searchController.searchBar.barTintColor = UIColor(red:52.0/255.0,green:200.0/255.0,blue:114.0/255.0,alpha:1.0)
        searchController.searchBar.tintColor = UIColor.blue
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredData = searchController.isActive ? [] : list
        
//        if searchController.isActive {
//            filteredData = []
//        } else {
//            filteredData = list
//        }
        
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                filteredData = list.filter({ (data) -> Bool in
                    return data.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                })
            }
        }
        tableView.reloadData()
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            filteredData.remove(at: indexPath.row)
            list.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}




