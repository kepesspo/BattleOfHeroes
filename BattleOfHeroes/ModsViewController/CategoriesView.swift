//
//  CategoriesView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/1/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class CategoriesView: UIView {
    

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("CategoriesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        categoriesLabel.text = "Válassz egy kategóriát és körbe megy a kör, mindenkinek kell mondania egy olyan szót, amely illeszkedik a kategoriához. Akinek nem sikerül az iszik"
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        contentView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}
