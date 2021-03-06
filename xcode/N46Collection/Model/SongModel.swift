//
//  SongModel.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/24/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation

struct SongModel {
    private(set) var cards: [Card]
    
    var displayCards: [Card] {
        cards.filter {
            !$0.isHidden
        }
    }
    
    var singleCards: [Card] {
        cards.filter {
            $0.content.type == "シングル"
        }
    }
    
    var albumCards: [Card] {
        cards.filter {
            $0.content.type == "アルバム"
        }
    }
    
    var bestAlbumCards: [Card] {
        cards.filter {
            $0.content.type == "ベストアルバム"
        }
    }
    
    var downloadSingleCards: [Card] {
        cards.filter {
            $0.content.type == "配信シングル"
        }
    }


    mutating func hide(card: Card) {
        //        print("\(card) is hide!")
        let index = self.cards.firstIndex(matching: card)
        cards[index!].hide()
    }

    mutating func display(card: Card) {
        //        print("\(card) is displayed!")
        let index = self.cards.firstIndex(matching: card)
        cards[index!].display()
    }

    mutating func sortCard(by: (Card, Card) -> Bool) {
        cards.sort(by: by)
    }
    
    init(numsOfPairsOfCards: Int, cardContentFactory: (Int) -> NogizakaSong) {
        self.cards = [Card]()
        
        for pairIndex in 0..<numsOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            let card = Card(content: content, id: pairIndex)
            self.cards.append(card)
        }
        self.sortCard(by: {
            $0.content.release_date > $1.content.release_date
        })
    }

    
    
    struct Card: Identifiable {
        var isHidden = false

        var content: NogizakaSong
        var id: Int

        mutating func hide() {
            isHidden = true
        }

        mutating func display() {
            isHidden = false
        }
    }
}
