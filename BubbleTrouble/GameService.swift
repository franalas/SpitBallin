//
//  GameService.swift
//  BubbleTrouble
//
//  Created by Liam Stevenson on 1/28/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol GameServiceDelegate {
    
    func receivedRotationalDelta(manager: GameService, delta: Double)
    func receivedTap(manager: GameService)
    
}

class GameService: NSObject {
    
    private let GameServiceType = "game-service"
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    
    private lazy var session: MCSession = {
        let session = MCSession(peer: self.myPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        return session
    }()
    
    var delegate: GameServiceDelegate?
    
    override init() {
        
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: GameServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: GameServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
        
    }
    
    deinit {
        
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
        
    }
    
    func send(message: String) {
        
        NSLog("%@", "sendRotationalDelta: \(message) to \(session.connectedPeers.count) peers")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send("\(message)".data(using: .utf8)!, toPeers: session.connectedPeers, with: .unreliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
    func send(rotationalDelta: Double) {
        
        NSLog("%@", "sendRotationalDelta: \(rotationalDelta) to \(session.connectedPeers.count) peers")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send("\(rotationalDelta)".data(using: .utf8)!, toPeers: session.connectedPeers, with: .unreliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
    func sendTap() {
        
        NSLog("%@", "sendTap to \(session.connectedPeers.count) peers")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send("tap".data(using: .utf8)!, toPeers: session.connectedPeers, with: .unreliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
}

extension GameService: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
        
    }
    
}

extension GameService: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        NSLog("%@", "lostPeer: \(peerID)")
    
    }
    
}

extension GameService: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        NSLog("%@", "didReceiveData: \(data)")
        
        let str = String(data: data, encoding: .utf8)!
        if str == "tap" {
            self.delegate?.receivedTap(manager: self)
        } else {
            self.delegate?.receivedRotationalDelta(manager: self, delta: Double(str)!)
        }
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
        NSLog("%@", "didReceiveStream")
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
        NSLog("%@", "didStartReceivingResourceWithName")
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
        NSLog("%@", "didFinishReceivingResourceWithName")
        
    }
    
}
