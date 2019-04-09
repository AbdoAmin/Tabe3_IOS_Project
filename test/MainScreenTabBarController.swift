//
//  MainScreenTabBarController.swift
//  test
//
//  Created by ashraf on 4/1/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import UIKit

class MainScreenTabBarController: UITabBarController {
    var mode:Bool=true
    var storyBoard:UIStoryboard!
    var mainScreen:HomeMovieCollectionViewController!
    
    @IBAction func swithBtn(_ sender: Any) {
        mode = !mode
        mainScreen.refreshTo(mode: mode)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          storyBoard = UIStoryboard(name: "Main", bundle:nil)
          mainScreen = storyBoard.instantiateViewController(withIdentifier: "mainMovieCollectionView") as! HomeMovieCollectionViewController
        // Do any additional setup after loading the view.
    }
    
   

}
