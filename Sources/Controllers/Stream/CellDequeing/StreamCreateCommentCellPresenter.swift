//
//  StreamCreateCommentCellPresenter.swift
//  Ello
//
//  Created by Colin Gray on 3/10/2015.
//  Copyright (c) 2015 Ello. All rights reserved.
//

struct StreamCreateCommentCellPresenter {

    static func configure(
        cell:UICollectionViewCell,
        streamCellItem:StreamCellItem,
        streamKind: StreamKind,
        indexPath: NSIndexPath)
    {
        if let cell = cell as? StreamCreateCommentCell {
            let comment = streamCellItem.jsonable as! Comment
            let user = comment.author
            cell.avatarURL = user?.avatarURL
        }
    }

}