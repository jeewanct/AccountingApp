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
    
    func showDataIndicator(){
        
        let loaderView: LoaderView = UIView.fromNib()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loaderView)
        
        loaderView.loader.startAnimating()
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    func hideDataIndicator(){
        
        for subview in self.view.subviews{
            if subview is LoaderView{
                subview.removeFromSuperview()
            }
        }
        
    }
}


extension UIButton{
    
    var isEmpty: Bool{
        if self.title(for: .normal) == CameraEnum.select.rawValue{
            return true
        }
        return false
    }
    
    func addButtonIndicator(){
        
        self.setTitle("", for: .normal)
        self.isUserInteractionEnabled = false
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
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


extension UITextField{
    
    func leftMargins(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height * 0.07 * 0.5 + 16, height: 0))
        self.leftView = leftView
        self.leftViewMode = .always
        
    }
    
}

extension Array{
    
    func convertImageToData(images: [UIImage]) -> [Data]{
        
        return images.map { (image) -> Data in
            return image.jpegData(compressionQuality: 0.1)!
        }
        
    }
}

extension UIView{
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top: top, left:left, bottom:  bottom, right: right, topConstant:  0 , leftConstant:  0 , bottomConstant:  0 , rightConstant:  0 )
    }
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0 , leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0,rightConstant: CGFloat = 0){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
    }
}

