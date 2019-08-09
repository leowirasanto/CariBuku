//
//  BookDetailViewController.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/9/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Alamofire
import UIKit
import Hero

class BookDetailViewController: UIViewController {
    @IBOutlet weak var imgContainer: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var book = BookItem()
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if let sUrl = book.generatedImageUrl as? String, book.id != "" {
            imgContainer.hero.id = book.id
            if let url = URL(string: sUrl) {
                imgContainer.af_setImage(withURL: url)
            }
        }
        titleLbl.text = book.volumeInfo.title
        descLbl.text = book.volumeInfo.description
        // Do any additional setup after loading the view.
    }
    @IBAction func handlePanGesture(_ sender: Any) {
        let sender_ = sender as! UIPanGestureRecognizer
        let translation = sender_.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        switch sender_.state {
        case .began:
            self.dismiss(animated: true)
        case .changed :
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: view)
            
        default:
            if progress + sender_.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
