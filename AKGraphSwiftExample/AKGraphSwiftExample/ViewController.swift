//
//  ViewController.swift
//  AKGraphSwiftExample
//
//  Created by Anton Korolev on 29.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let graphBar = AKGraphBar()
    let builder  = AKBulderGraph()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        graphBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func randomBarAction(sender: UIButton) {
        builder.changeSettingsBarRandom(graphBar)
    }
}

extension ViewController: AKGraphBarDelegate {
    
    func sizeOfImageInGraphBar(graphBar: AKGraphBar) -> CGRect {
        return imageView.bounds
    }
    
    func graphBar(graphBar: AKGraphBar, drawImage image: UIImage?) {
        imageView.image = image
    }
}

