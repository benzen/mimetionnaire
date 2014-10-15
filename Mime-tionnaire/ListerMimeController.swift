//
//  ListerMimeController.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-10.
//  Copyright (c) 2014 Benjamin Dreux, Pascal Chouinard. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ListerMimeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView?
    
    let store: MimeStore = MimeStore()
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("count line called \(store.listMime().count)" )
//        return store.listMime().count
        return  store.listMime().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        let model: MimeModel = self.store.listMime()[indexPath.row] as MimeModel
        cell.textLabel?.text = model.nom
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let model = self.store.listMime()[indexPath.row] as MimeModel
        playVideo(model.videoUrl)
    }
    
    func playVideo(videoUrl:String){
        
//        if let avpVC = childViewControllers.first as? AVPlayerViewController{
        let avpVC = AVPlayerViewController()
//        dispatch_async(dispatch_get_main_queue()){
            let url = NSURL(string: videoUrl)
            avpVC.player = AVPlayer.playerWithURL(url) as AVPlayer
//        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

