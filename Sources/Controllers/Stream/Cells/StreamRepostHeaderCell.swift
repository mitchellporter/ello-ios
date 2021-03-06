//
//  StreamRepostHeaderCell.swift
//  Ello
//
//  Created by Ryan Boyajian on 4/23/15.
//  Copyright (c) 2015 Ello. All rights reserved.
//

public class StreamRepostHeaderCell: UICollectionViewCell {
    static let reuseIdentifier = "StreamRepostHeaderCell"

    @IBOutlet var repostedByLabel: ElloLabel!
    @IBOutlet var repostIconView: UIImageView!
    weak var userDelegate: UserDelegate?

    var atName: String = "" {
        didSet {
            if atName != "" {
                repostedByLabel.setLabelText("by \(atName)", color: UIColor.greyA())
            }
            else {
                repostedByLabel.setLabelText("")
            }
            setNeedsUpdateConstraints()
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        repostIconView.image = InterfaceImage.Repost.selectedImage
        repostedByLabel.numberOfLines = 0
        repostedByLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
    }

}
