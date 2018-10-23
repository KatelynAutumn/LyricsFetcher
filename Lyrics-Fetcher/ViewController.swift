//
//  ViewController.swift
//  Lyrics-Fetcher
//
//  Created by Katelyn Pace on 10/23/18.
//  Copyright © 2018 Katelyn Pace. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//the base URL for the lyrics API, aka the point where we connect to it
let lyricsAPIBaseURL = "https://api.lyrics.ovh/v1/"

class ViewController: UIViewController {

    @IBOutlet weak var Artist: UITextField!
    
    @IBOutlet weak var Song: UITextField!
    
    @IBOutlet weak var Lyrics: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func SubmitButtonTapped(_ sender: Any) {
        
        guard let artistName = Artist.text,
            let songTitle = Song.text else {
            return
        }
        
        //Since we can't use spaces in our URL, we need to replace spaces in the song and artist name with +
        let artistNameURLComponent = artistName.replacingOccurrences(of: " ", with: "+")
        let songTitleURLComponent = songTitle.replacingOccurrences(of: " ", with: "+")
        
        
        //Full URL for the request, we will make to the API
        let requestURL = lyricsAPIBaseURL + artistNameURLComponent + "/" + songTitleURLComponent
        
        //We are going to use Alamofire to create an actual request using that URL
        let request = Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        
        //Now we need to actually make our request
        request.responseJSON { response in
            switch response.result {
            case .success(let value): //In the case of success, the response has succeeded, and we have gotten some data back
                print(value)
                
                let json = JSON(value)
                
                print(json)
                
                self.Lyrics.text = json["lyrics"].stringValue
                
                print("Success!")
            case.failure(let error): //In the case of failure, the rquest has failed and we've gotten an error back
                print("Error.")
                print(error.localizedDescription)
            }
        }
    }
    
}

