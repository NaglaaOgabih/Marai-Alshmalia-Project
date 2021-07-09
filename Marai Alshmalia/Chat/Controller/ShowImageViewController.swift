//
//  ShowImageViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 15/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = ShowImageViewController()
        updateZoomFor(size: view.bounds.size)

        // Do any additional setup after loading the view.
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }

    func updateZoomFor(size: CGSize){
        let widthScale = size.width / imgView.bounds.width
        let heightScale = size.height / imgView.bounds.height
        let scale = min(widthScale,heightScale)
        scrollView.minimumZoomScale = scale
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
