//
//  MovieCell.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell{
    
    
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var voteAverage: UILabel!   
    
    override func awakeFromNib() {
      super.awakeFromNib();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
    }
    
}
