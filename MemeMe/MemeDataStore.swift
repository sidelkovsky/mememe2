//
//  MemeDataStore.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 27.10.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

class MemeDataStore {
    
    static let shared = MemeDataStore()
    private var memes = [Meme]()
    
    private init(){}
    
    func save(meme: Meme){
        
        memes.append(meme)
        
        print("\(memes.count)")
        
    }
    
    func getMemes() -> [Meme] {
        
        return memes
        
    }
}

// MemeDataStore.shared.save(meme: memeObj)
// let memes = MemeDataStore.shared.getStoredMeme()
