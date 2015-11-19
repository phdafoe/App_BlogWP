//
//  ICOLastPostWPTableViewController.swift
//  App_BlogWP
//
//  Created by User on 19/11/15.
//  Copyright © 2015 iCologic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ICOLastPostWPTableViewController: UITableViewController {
    
    //MARK: - IBOUTLET
    
    
    
    
    //MARK: - VARIABLES LOCALES
    
    // Aqui alimentamos esta variable con un JSON del sitio de WordPress
    let lastPosts: String = "https://wlcdesigns.com/wp-json/wp/v2/posts/"
    let parameters : [String:AnyObject] = ["filter[category_name]": "tutorials", "filter[post_per_page]": 5]
    var json : JSON = JSON.null
    

    //MARK: - LIFE APP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Metodo Auxiliar llamamos directamete a nuestra variable lastPost por tanto pasamos la url
        getPostWP(lastPosts)
        
        
        //Aqui colocamos un refreshControl
        let refresshControl = UIRefreshControl() // alloc init
        refresshControl.addTarget(self, action: "newNews", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresshControl
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - GET POST - UTILS
    
    func getPostWP(getposts : String){

        Alamofire.request(.GET, getposts, parameters:parameters)
        
            .responseJSON { response in
                
            switch response.result {
                
            case .Success(let data):
                self.json = JSON(data)
                self.tableView.reloadData()
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                
                }
        }

    }


    func populatesFields(cell: ICOCustomTableViewCell, index: Int){
        
        //Hacer seguro el titulo del post un String
        guard let title = self.json[index]["title"]["rendered"].string else{
            cell.myPostTitle!.text = "Cargando..."
            return
        }
        
        //Una accion debe siempre proceder de la condicion del "guard"
        cell.myPostTitle.text = title
        
        // Hacer seguro la fecha del post un String
        guard let date = self.json[index]["date"].string else{
            cell.myPOstDate!.text = "--"
            return
        }
        
        cell.myPOstDate!.text = date
        
        
        //Ajustamos la imagen
        
        guard let image = self.json[index]["featured_image_thumbnail_url"].string where
        
        image != "null"
            else{
                print("Imagen no cargada")
                return
        }
        
        ImageLoader.sharedloader.imageForUrl(image) { (image: UIImage?, url: String) -> () in
            cell.myPostImage.image = image!
        }
   
    }
    
    func newNews()
    {
        getPostWP(lastPosts)
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch json.type{
            
        case Type.Array:
            return self.json.count
        default:
            return 1
            
        }
  
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ICOCustomTableViewCell
        
        populatesFields(cell, index: indexPath.row)

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // A cual view controller le enviaremos esto
        let detailScene = segue.destinationViewController as! ICOWebViewController
        
        // pasamos el JSON seleccioando 
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let selected = self.json[indexPath.row]
            detailScene.viewPost = selected
        }
        
        
        
    }
    
    
    

}
