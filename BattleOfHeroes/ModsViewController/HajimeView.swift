//
//  HajimeView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class HajimeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hajimeTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("HajimeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        hajimeTextLabel.text = "A jatákosok egy körtbe ülnek, és valaki elkezdi a jatékot. Az első játékos azt mondja: egy, a következő kettő, majd a három, és így tovább. Bizonyos számokat azonban fel kell váltani a Hajime szóval. Nem kimondható számot a következőkre: \n Bármelyik szám, amely tartalmazza a hetes számot. Például. 7., 17., 27., stb. \n A hétes számának többszöröse. Például. 7., 14., 21., 28., stb. \n Bármely kétjegyű szám. Például. 11., 22., 33. stb. \n Illetve ha valaki a Hajime szót kimondja akkor a kör megfordul. Akinek nem sikerül az iszik"
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        contentView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}
