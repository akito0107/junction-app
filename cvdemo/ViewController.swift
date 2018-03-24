//
//  ViewController.swift
//  cvdemo
//
//  Created by Akito Ito on 2018/03/24.
//  Copyright © 2018 Akito Ito. All rights reserved.
//

import UIKit
import Foundation

struct ParseError: Error {}

class ViewController: UIViewController {

    @IBOutlet weak var displayImageView:UIImageView!
    let openCV = OpenCVWrapper()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        displayImageView.isUserInteractionEnabled = true
        displayImageView.addGestureRecognizer(tapGestureRecognizer)
        openCV.createCamera(displayImageView)
               // クルクルをストップした時に非表示する
        
        activity.hidesWhenStopped = true
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openCV.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let touchPoint = (tapGestureRecognizer.location(in: self.view))
        let out = openCV.getCode(Float(touchPoint.x), y:Float(touchPoint.y));
        print(touchPoint.x)
        print(touchPoint.y)
        
        print(out)
        
        if (out < 0) {
            return
        }
        
        let url = "http://139.59.38.208?id=" + String(out)
        let config  = URLSessionConfiguration.default;
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main);
        let request = URLRequest(url: URL(string: url)!);
        activity.startAnimating()
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if ((error) == nil) {
                do {
                    self.activity.stopAnimating()
                    let d = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String;
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "tableview") as? TableViewController
                    guard let data = d.data(using: .utf8) else {
                        throw ParseError()
                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    self.activity.stopAnimating()
                    let top = json as! [Any]
                    nextView!.json = top
                    self.present(nextView!, animated: true, completion: nil)
                } catch {
                    print(error)
                    return
                }
               
               
            } else {
                print(error)
                print("AsyncGetHttpRequest:Error");
            }
        };
        
        task.resume();
    }
    
    
}

