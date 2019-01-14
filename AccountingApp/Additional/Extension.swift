//
//  Extension.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 08/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIViewController{
    
    func notInternetView(){
        
        let internetView: NoConnectionView = UIView.fromNib()
        self.view.addSubview(internetView)
        
        internetView.translatesAutoresizingMaskIntoConstraints = false
        internetView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        internetView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        internetView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        internetView.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        internetView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .autoreverse, animations: {
            internetView.transform = .identity
            
        }) { (value) in
            //internetView.removeFromSuperview()
            internetView.removeFromSuperview()
        }
        
    }
}


extension UIButton{
    
    
    
    func addButtonIndicator(){
        
        self.setTitle("", for: .normal)
        self.isUserInteractionEnabled = false
        
        let activityIndicator = UIActivityIndicatorView(style: .white)
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
    }
    
    func hideButtonIndicator(title: String){
        
        self.setTitle(title, for: .normal)
        self.isUserInteractionEnabled = true
        
        for subView in self.subviews{
            if subView is UIActivityIndicatorView{
                subView.removeFromSuperview()
            }
        }
        
    }
    
}
