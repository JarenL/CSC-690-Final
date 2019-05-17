//
//  FirstViewController.swift
//  Music Player
//
//  Created by Jaren Lynch on 5/15/19.
//  Copyright © 2019 Jaren Lynch. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseUI

var audioPlayer = AVAudioPlayer()
var songs:[String] = []
var thisSong = 0
var audioStuffed = false

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FUIAuthDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songs.count
    }
    
    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    @IBAction func upload(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
        }
        catch
        {
            print ("ERROR")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gettingSongNames()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //FUNCTION THAT GETS THE NAME OF THE SONGS
    func gettingSongNames()
    {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            //loop through the found urls
            for song in songPath
            {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                }
                
            }
            
            myTableView.reloadData()
        }
        catch
        {
            print ("ERROR")
        }
    }
}

