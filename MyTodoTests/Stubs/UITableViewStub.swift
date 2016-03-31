//
// Created by Rene Pirringer on 30.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class UITableViewStub : UITableView {

    var hasReloadData = false
    var deleteRowsAtIndexPaths = [NSIndexPath]()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func reloadData() {
        hasReloadData = true
    }
    
    override func deleteRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        deleteRowsAtIndexPaths = indexPaths
    }


}
