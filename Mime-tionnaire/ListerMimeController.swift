//
//  ListerMimeController.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-10.
//  Copyright (c) 2014 Benjamin Dreux. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ListerMimeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet
    var tableView: UITableView?
    
    @IBOutlet
    var searchBar: UISearchBar?
    
    
    let store: MimeStore = MimeStore()
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
            self.tableView?.reloadData()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar?.text = nil
        hideSearchBar()
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  store.listMime(searchBar?.text).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        let model: MimeModel = self.store.listMime(searchBar?.text)[indexPath.row] as MimeModel
        cell.textLabel?.text = model.nom
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.performSegueWithIdentifier("playVideo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "playVideo") {
            let indexPath = tableView?.indexPathForSelectedRow()
            let model = self.store.listMime(searchBar?.text)[indexPath!.row] as MimeModel
            let url = NSURL(string: model.videoUrl)
            if let subVC = segue.destinationViewController as? AVPlayerViewController {
                subVC.player = AVPlayer(URL: url)
                subVC.player.play()
            }
        }
        hideSearchBar()
    }
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let model = store.listMime(searchBar?.text)[indexPath.row]
            store.delete(model)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        hideSearchBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        hideSearchBar()
        self.tableView?.reloadData()
    }

    func hideSearchBar(){
        var frame = self.tableView?.frame
        let isSearchBarVisible = CGRectIntersectsRect(frame!, searchBar!.frame)

        if isSearchBarVisible {
            let y = self.tableView!.contentOffset.y + self.searchBar!.frame.height
            let newContentOffset = CGPoint(x:0, y: y)
            
            println("DID HIDE")
            println("old bound \(frame)")
            println("searchBarHeight \(self.searchBar!.frame.height)")
            println("contentOffset \(self.tableView!.contentOffset.y)")
            println("new content offset \(newContentOffset)")
            println("")

            self.tableView?.setContentOffset( newContentOffset, animated:true)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

