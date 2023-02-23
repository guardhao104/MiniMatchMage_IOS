//
//  GameCombat.swift
//  MiniMatchMage
//
//  Created by Chelsea Kung on 2023/2/22.
//

import Foundation

struct player {
    var health: Int
    var shield: Int
    var spell1: Array<Any>
    var spell2: Array<Any>
    var spell3: Array<Any>
}

struct enemyType{
    var fighter:Any
    var archer:Any
    var mage:Any
}

let player1 = defaultPlayer
var enemyhealth:Int = 100

func castSpell (_ element:String,_ number:Int){
    if element == "fire"{
        if number == 1{
            print (player1.spell1[0])
            //enemyhealth = enemyhealth - player1.spell1[0]
        }
    }
}

