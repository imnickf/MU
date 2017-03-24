//
//  MessagesCollectionViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/23/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class MessagesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
  
}


    // MARK: - Navigation

extension MessagesCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
}

    // MARK: UICollectionViewDataSource

extension MessagesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as UICollectionViewCell
        return cell
    }
}

    // MARK: UICollectionViewDelegate

extension MessagesCollectionViewController {
  
}
