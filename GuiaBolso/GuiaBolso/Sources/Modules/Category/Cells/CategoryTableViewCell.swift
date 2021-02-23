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
    }

    //MARK: - Methods
    func setupCell(category: Categories, indexPath: Int) {
        self.lblCategoryName.text = category[indexPath].capitalized
    }
    
}
