//
//  ViewController.swift
//  SimpleRestAPITest
//
//  Created by Rajesh on 7/4/18.
//  Copyright © 2018 Rajesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    
    var selectedLocation: LocationModel = LocationModel()
    
    @IBOutlet weak var listTableVIew: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableVIew.delegate = self
        self.listTableVIew.dataSource = self

        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableVIew.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.address
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedLocation = feedItems[indexPath.row] as! LocationModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! DetailViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedLocation = selectedLocation
    }


}

