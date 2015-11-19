//
//  ICOWebViewController.swift
//  App_BlogWP
//
//  Created by User on 19/11/15.
//  Copyright © 2015 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class ICOWebViewController: UIViewController, UIWebViewDelegate {
    
    
    //MARK: - VARIABLES LOCALES
    var viewPost : JSON = JSON.null

    //MARK: - IB
    @IBOutlet weak var myWebView: UIWebView!
    
    
    
    //MARK: - LIFE APP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Hacer seguro el JSON que retorna del post a un String
        if let postLink = self.viewPost["link"].string{
            
            //Convertir la url string a un NSURL objeto
            let requestURL = NSURL(string: postLink)
            
            // Crear una solicitud desde NSURL
            let request = NSURLRequest(URL: requestURL!)
            
            myWebView.delegate = self
            
            //Cargar el Post
            myWebView.loadRequest(request)
            
            //Asignar al titulo del navigatio bar el que viene del post de Wordpress
            
            if let titleCustom = self.viewPost["title"].string{
                self.title = titleCustom
            }
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
