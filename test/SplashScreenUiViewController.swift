//
//  SplashScreenUiViewController.swift
//  test
//
//  Created by ashraf on 4/1/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import UIKit

class SplashScreenUiViewController: UIViewController {

    
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! NavigationScreen
            nextViewController.modalTransitionStyle = .flipHorizontal
            self.present(nextViewController, animated:true, completion:nil)
        })
        
    }
}
