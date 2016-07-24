//
//  ViewController.swift
//  Upload Image To Server
//
//  Created by Pablo Guardiola on 24/07/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func upload(sender: AnyObject) {
        // Getting image to test
        let imageToTest: UIImage? = UIImage(named: "imagen.png")
        
        // Image type
        let imageType: ImageToUploadType = ImageToUploadType.PNG
        
        // URL where you put the PHP file, in yout server
        let urlServer: String = "http://parseql.com/uploadImage.php"
        
        // If image is loaded then upload to server
        if imageToTest != nil {
            uploadImage (imageToTest!, imageType: imageType, urlString: urlServer) { (resp: String) in
                print(resp)
            }
        }
    }
}

