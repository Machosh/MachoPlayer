//
//  ViewController.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import UIKit
import Combine

struct MovieViewModel{}

class ViewController: UIViewController {

    var vm: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(":)")
        
//        Task{
//            await fetchVideoURL()
//        }
    }

    func fetchVideoURL() async {
        do{
            let res = try await MovieAPI.FetchMovies().asyncRequest()
            print(res)
        }catch{
            print(error)
        }
    }
    
    func pullVideoURL(){
        
    }
}

