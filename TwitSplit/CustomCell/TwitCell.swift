//
//  TwitCell.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 innoverzgen. All rights reserved.
//

import UIKit

class TwitCell: UITableViewCell {
    static let identifier = "TwitCell"
    let imagesArray:[String] = ["image1","image2","image3","image4"]
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    func setupUI() {
        avatarImageView.clipsToBounds = true   
    }
    
    func setupData(tweet: Tweet) {
        let number = Int.random(in: 0 ..< 4)
        avatarImageView.image = UIImage(named: imagesArray[number])
        userNameLabel.text = tweet.user
        messageLabel.text = tweet.message
        timeLabel.text = tweet.time.toString()
    }
}
