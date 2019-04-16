//
//  ReplyImagePreview.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 03/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class ReplyImagePreview: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dismissView: UIView!

    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func addTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        dismissView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: For zoom in & out images
extension ReplyImagePreview: UIScrollViewDelegate{
    func setup(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        imageView.addImage(url: imageName)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
