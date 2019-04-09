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
        (self.selectedViewController as? HomeMovieCollectionViewController)?.refreshTo(mode: mode)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//          storyBoard = UIStoryboard(name: "Main", bundle:nil)
//          mainScreen = storyBoard.instantiateViewController(withIdentifier: "mainMovieCollectionView") as! HomeMovieCollectionViewController
        // Do any additional setup after loading the view.
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        super.tabBar(tabBar, didSelect: item)
        if (self.selectedViewController as? HomeMovieCollectionViewController)?.restorationIdentifier == "fivoriteCollectionView"{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)

        }
    }
    
    
}
