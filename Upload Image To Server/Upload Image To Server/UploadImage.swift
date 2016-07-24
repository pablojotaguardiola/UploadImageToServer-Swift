//
//  UploadImage.swift
//  Pruebas Upload Image
//
//  Created by Pablo Guardiola on 23/07/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

public enum ImageToUploadType: String {
    case JPG
    case PNG
}

func uploadImage(image: UIImage, imageType: ImageToUploadType, urlString: String, completion: (String) -> ())
{
    let url = NSURL(string: urlString)
    
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    
    let boundary = generateBoundaryString()
    
    //define the multipart request type
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var image_data: NSData?
    
    switch imageType {
    case .JPG:
        image_data = UIImageJPEGRepresentation(image, 1)
        break
        
    case .PNG:
        image_data = UIImagePNGRepresentation(image)
        break
    }
    
    
    if(image_data == nil)
    {
        return
    }
    
    
    let body = NSMutableData()
    
    let fname = "test." + imageType.rawValue
    let mimetype = "image/" + imageType.rawValue
    
    //define the data post parameter
    
    body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("Content-Disposition:form-data; name=\"test\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("hi\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    
    
    body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData(image_data!)
    body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    
    body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    
    
    request.HTTPBody = body
    
    
    
    let session = NSURLSession.sharedSession()
    
    
    let task = session.dataTaskWithRequest(request) {
        (
        let data, let response, let error) in
        
        guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
            print(error)
            return
        }
        
        let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        dispatch_async(dispatch_get_main_queue()) {
            completion(dataString as! String)
        }
    }
    
    task.resume()
}


func generateBoundaryString() -> String
{
    return "Boundary-\(NSUUID().UUIDString)"
}