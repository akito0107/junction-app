//
//  TableCellTableViewCell.swift
//  cvdemo
//
//  Created by Akito Ito on 2018/03/25.
//  Copyright © 2018 Akito Ito. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(model :CellModel) {
        self.id.text = model.id
        self.desc.text = model.desc
        
   
        if let data = try? Data(contentsOf: model.imageUrl!)
        {
            self.icon.image = UIImage(data: data)
        }
       
    }

}
