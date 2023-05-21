//
//  HeroTableViewCell.swift
//  HeroisMarvel
//
//  Created by Abner Lima on 21/05/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var ivThumn: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        if let url = URL(string: hero.thumbnail.url) {
            ivThumn.kf.indicatorType = .activity
            ivThumn.kf.setImage(with: url)
        } else {
            ivThumn.image = nil
        }
        
        ivThumn.layer.cornerRadius = ivThumn.frame.size.height / 2
        ivThumn.layer.borderColor = UIColor.red.cgColor
        ivThumn.layer.borderWidth = 2
    }

}
