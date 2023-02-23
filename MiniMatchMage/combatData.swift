//
//  playerData.swift
//  MiniMatchMage
//
//  Created by Chelsea Kung on 2023/2/22.
//

import Foundation

var defaultPlayer = player(health: 300, shield: 0, spell1: castFire, spell2: castWater, spell3: castWind)

var castFire=[fireSpell1,fireSpell2,fireSpell3]
var fireSpell1 = ["damage": 75, "target": 1, "heal": 0]
var fireSpell2 = ["damage": 50, "target": 3, "heal": 0]
var fireSpell3 = ["damage": 100, "target": 3, "heal": 50]

var castWater=[waterSpell1,waterSpell2,waterSpell3]
var waterSpell1 = ["damage": 10, "target": 1, "tirgger": 0]
var waterSpell2 = ["damage": 10, "target": 3, "tirgger": 0]
var waterSpell3 = ["damage": 10, "target": 3, "tirgger": 1]

var castWind=[windSpell1,windSpell2,windSpell3]
var windSpell1 = ["shield": 100, "target": 1, "delay": 0]
var windSpell2 = ["shield": 200, "target": 1, "delay": 0]
var windSpell3 = ["shield": 200, "target": 3, "delay": 1]
	
var enemySwpan = enemyType(fighter: fighterEnemy, archer: archerEnemy, mage:mageEnemy)
var fighterEnemy = ["health": 200,"attack":20, "defend": 20, "speed": 2]
var archerEnemy = ["health": 150, "attack":40,"defend": 10, "speed": 3]
var mageEnemy = ["health": 100, "attack":100,"defend": 0, "speed": 5]

