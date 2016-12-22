//
//  FileListTableViewCell.swift
//  DocumentDirectorySampleApp
//
//  Created by webonise on 20/12/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

class FileListTableViewCell: UITableViewCell {

	@IBOutlet var labelFileName: UILabel!
	@IBOutlet var labelCreatedAt: UILabel!
	@IBOutlet var labelFileCreationDate: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
