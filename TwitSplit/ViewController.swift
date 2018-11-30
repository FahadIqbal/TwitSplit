//
//  ViewController.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 innoverzgen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Actions
    @IBAction func onAddMessageButton(_ sender: UIBarButtonItem) {
        addTweetPopup = showAddTweetPopup { (message) in
            
            self.createSplit(message: message)
        }
        
        addTweetPopup?.textFields?.first?.delegate = self
    }
    
    // MARK: Create Splittwit
    func createSplit(message:String){
        
        let needToSplit = Utils.checkToSplit(message: message)
        
        if (needToSplit) {
            let splitMessages = Utils.splitMessage(message: message,vc:self)
            
            splitMessages.forEach({ (message) in
                self.addTweet(message: message)
            })
        } else {
            self.addTweet(message: message)
        }
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var tweets = [Tweet]()
    var addTweetPopup: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
         self.createSplit(message: "The burger is made with habanero peppers, ghost chilis, and secret hot sauce, as well as two Angus beef patties, maple bacon, cheese, pickles, jalapeños, tomato, and lettuce. Ghost chilis alone are considered the hottest chilis in the world, measuring between 855,000 and 1,041,427 SHU (Scoville Heat Units).")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addTweet(message: String) {
        let tweet = Tweet(user: kUser, message: message, time: Date())
        tweets.insert(tweet, at: 0)
        self.tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitCell.identifier) as? TwitCell else { fatalError() }
        let tweet = tweets[indexPath.row]
        cell.setupData(tweet: tweet)
        return cell
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if (newLength <= kMaxlength) {
            addTweetPopup?.title = "New Tweet (\(kMaxlength - newLength))"
        } else {
            let partCount = newLength / kMaxlength + 1
            addTweetPopup?.title = "New Tweet (\(partCount)/\(partCount))"
        }
        return true
    }
}

