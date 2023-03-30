//
//  CombatData.swift
//  MiniMatchMage
//
//  Created by Chelsea Kung on 2023/2/22.
//

import Foundation

struct Player {
    var maxhealth: Int
    var health: Int
    var shield: Int
    var spell1: [[String: Any]]
    var spell2: [[String: Any]]
    var spell3: [[String: Any]]
}


//struct EnemyType {
//    var fighter: [String: Any]
//    var archer: [String: Any]
//    var mage: [String: Any]
//}

var defaultPlayer = Player(maxhealth: 300, health: 300, shield: 0, spell1: castFire, spell2: castWater, spell3: castWind)

var poisonDamage = 10;

var fireSpell1 = ["damage": 75, "target": 1, "heal": 0] as [String: Any]
var fireSpell2 = ["damage": 50, "target": 3, "heal": 0] as [String: Any]
var fireSpell3 = ["damage": 100, "target": 3, "heal": 50] as [String: Any]
var castFire=[fireSpell1,fireSpell2,fireSpell3]

var waterSpell1 = ["damage": 10, "target": 1, "trigger": 0] as [String: Any]
var waterSpell2 = ["damage": 10, "target": 3, "trigger": 0] as [String: Any]
var waterSpell3 = ["damage": 10, "target": 3, "trigger": 1] as [String: Any]
var castWater=[waterSpell1,waterSpell2,waterSpell3]

var windSpell1 = ["shield": 100, "target": 1, "delay": 0] as [String: Any]
var windSpell2 = ["shield": 200, "target": 1, "delay": 0] as [String: Any]
var windSpell3 = ["shield": 200, "target": 3, "delay": 1] as [String: Any]
var castWind=[windSpell1,windSpell2,windSpell3]


var fighterEnemy = ["maxHealth": 200, "health": 200,"attack":20, "defend": 20, "speed": 2, "defaultSpeed":2, "poison":0] as [String: Any]
var archerEnemy = ["maxHealth": 150, "health": 150, "attack":40,"defend": 10, "speed": 3, "defaultSpeed":3, "poison":0] as [String: Any]
var mageEnemy = ["maxHealth": 100, "health": 100, "attack":100,"defend": 0, "speed": 4, "defaultSpeed":4, "poison":0] as [String: Any]



//var defaultPlayer = player(health: 300, shield: 0, spell1: castFire, spell2: castWater, spell3: castWind)
//
//var fireSpell1 = ["damage": 75, "target": 1, "heal": 0] as [String: Any]
//var fireSpell2 = ["damage": 50, "target": 3, "heal": 0] as [String: Any]
//var fireSpell3 = ["damage": 100, "target": 3, "heal": 50] as [String: Any]
//var castFire=[fireSpell1,fireSpell2,fireSpell3]
//
//var waterSpell1 = ["damage": 10, "target": 1, "trigger": 0] as [String: Any]
//var waterSpell2 = ["damage": 10, "target": 3, "trigger": 0] as [String: Any]
//var waterSpell3 = ["damage": 10, "target": 3, "trigger": 1] as [String: Any]
//var castWater=[waterSpell1,waterSpell2,waterSpell3]
//
//var windSpell1 = ["shield": 100, "target": 1, "delay": 0] as [String: Any]
//var windSpell2 = ["shield": 200, "target": 1, "delay": 0] as [String: Any]
//var windSpell3 = ["shield": 200, "target": 3, "delay": 1] as [String: Any]
//var castWind=[windSpell1,windSpell2,windSpell3]
//
//
//var fighterEnemy = ["health": 200,"attack":20, "defend": 20, "speed": 2]
//var archerEnemy = ["health": 150, "attack":40,"defend": 10, "speed": 3]
//var mageEnemy = ["health": 100, "attack":100,"defend": 0, "speed": 5]
//var enemySwpan = enemyType(fighter: fighterEnemy, archer: archerEnemy, mage:mageEnemy)
