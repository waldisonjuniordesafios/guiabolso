//
//  CategoryTableViewCell.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var lblCategoryName: UILabel!

    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
