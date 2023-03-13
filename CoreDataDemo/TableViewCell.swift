//
//  TableViewCell.swift
//  CoreDataDemo
//
//  Created by MBA-0019 on 13/03/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ShowImageView: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
