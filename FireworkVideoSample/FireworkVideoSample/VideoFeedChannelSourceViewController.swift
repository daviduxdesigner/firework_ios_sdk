//
//  VideoFeedChannelSourceViewController.swift
//  FireworkVideoSample
//
//  Copyright © 2021 Firework. All rights reserved.
//

import UIKit

import FireworkVideo

class VideoFeedChannelSourceViewController: UIViewController, VideoFeedViewControllerDelegate {
    var embeddedVideoFeedViewController:VideoFeedViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Video Feed from Channel Source"
        self.view.backgroundColor = UIColor.secondarySystemBackground
        
        let horizontalVideoFeedLayout = VideoFeedLayoutTypes.horizontalVideoFeedLayout()
        /// Try to set any public channel from https://fw.tv here and relaunch the sample app
        /// The video feed will update to reflect the content of the channel
        let channelVideoSource = VideoFeedContentSource.channel(channelID: "mesh")
        
        self.embeddedVideoFeedViewController = VideoFeedViewController(layout: horizontalVideoFeedLayout,
                                                                       source: channelVideoSource)
        self.embeddedVideoFeedViewController.delegate = self
        
        self.setupVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController,
                            topSpacing: 20.0,
                            fullHeight: false)
    }
    
    func videoFeedDidLoadFeed(_ viewController: FireworkVideo.VideoFeedViewController) {
        print("Did Load Feed")
    }

    /// Called if the video feed failed to load
    func videoFeed(_ viewController: FireworkVideo.VideoFeedViewController, didFailToLoadFeed error: FireworkVideo.VideoFeedError) {
        if case let FireworkVideo.VideoFeedError.contentSourceError(contentSourceError) =  error {
            print("Video feed on view controller \(viewController) loaded with error \(contentSourceError.localizedDescription).")
        } else if case let FireworkVideo.VideoFeedError.unknownError(underlyingError) = error {
            print("Video feed on view controller \(viewController) loaded with error \(underlyingError.localizedDescription).")
        }
    }
}
