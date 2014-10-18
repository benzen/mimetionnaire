//
//  AjouterMimeViewController.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-10.
//  Copyright (c) 2014 Benjamin Dreux. All rights reserved.
//

import UIKit
import MobileCoreServices


class AjouterMimeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var nomLabel : UILabel!
    @IBOutlet var videoLabel : UILabel!
    @IBOutlet var nomTextField : UITextField!
    @IBOutlet var videoButton : UIButton!
    
    @IBOutlet var ajouterButton : UIButton!
    @IBOutlet var cancelButton : UIButton!
    
    @IBAction func addMime(sender : AnyObject) {
        self.model.nom = nomTextField.text
        let store = MimeStore()
        store.addMime(self.model)

        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
    @IBAction func nomChanged(sender : AnyObject) {
        nomTextField.text = model.nom
    }

    let model = MimeModel(nom:"", videoUrl:"")
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!){
        var url = info.objectForKey(UIImagePickerControllerReferenceURL) as NSURL
        model.videoUrl = url.absoluteString!

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func refreshUI(){
        nomTextField.text = model.nom
    }

    @IBAction func selectVideo(){

        var ipController = UIImagePickerController()
        ipController.delegate = self
        ipController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        ipController.mediaTypes = NSArray(object: kUTTypeMovie)
        ipController.allowsEditing = false
    
        self.presentViewController(ipController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        refreshUI()
        nomTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

