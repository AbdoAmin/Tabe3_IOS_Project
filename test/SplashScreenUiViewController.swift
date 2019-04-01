//
//  SplashScreenUiViewController.swift
//  test
//
//  Created by ashraf on 4/1/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import UIKit

class SplashScreenUiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! HomeMovieCollectionViewController
        self.present(nextViewController, animated:true, completion:nil)
    }


}
