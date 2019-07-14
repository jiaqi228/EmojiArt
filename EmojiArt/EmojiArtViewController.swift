//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Huang Jiaqi on 2019/07/14.
//  Copyright © 2019 Huang Jiaqi. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    // Conform to the UIDropInteractionDelegate's (option) method.
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        imageFetcher = ImageFetcher(){ (url, image) in
            // For the data being displayed on view,
            // To do this, we have to dispatch it to main queue to execution.
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }
        
        session.loadObjects(ofClass: NSURL.self, completion: { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        })
        
        session.loadObjects(ofClass: UIImage.self, completion: { uiimages in
            if let image = uiimages.first as? UIImage {
                self.imageFetcher.backup = image
            }
        })
    }
    
    @IBOutlet weak var emojiArtView: EmojiArtView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
