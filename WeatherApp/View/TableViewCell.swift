//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Mobile Apps Team on 2/8/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
