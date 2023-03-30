//
//  CombatSysytem.swift
//  MiniMatchMage
//
//  Created by Chelsea Kung on 2023/2/22.
//

import Foundation

var enemyList: [[String: Any]] = []

func getEnemy(levelofGame: Int) -> [[String: Any]] {
    switch levelofGame {
    case 1:
        enemyList+=[fighterEnemy,fighterEnemy,archerEnemy];
    case 2:
        enemyList+=[fighterEnemy,archerEnemy,archerEnemy];
    case 3:
        enemyList+=[fighterEnemy,archerEnemy,mageEnemy];
    default:
        break
    }
    return enemyList
}



func castSpell(_ element: String, _ number: Int) {
    switch element {
    case "fire":
        switch number {
        case 1:
            print(defaultPlayer.spell1[0])
            let damage = defaultPlayer.spell1[0]["damage"] as! Int
            for i in 0..<1 {
                let health = enemyList[i]["health"] as! Int
                let defend = enemyList[i]["defend"] as! Int
                let newHealth = health - damage + defend;
                enemyList[i]["health"] = newHealth;
            };
        case 2:
            print(defaultPlayer.spell1[1])
            let damage = defaultPlayer.spell1[1]["damage"] as! Int
            for i in 0..<1 {
                let health = enemyList[i]["health"] as! Int
                let defend = enemyList[i]["defend"] as! Int
                let newHealth = health - damage + defend;
                enemyList[i]["health"] = newHealth;
            };
        case 3:
            print(defaultPlayer.spell1[2])
            let heal = defaultPlayer.spell1[2]["heal"] as! Int
            let damage = defaultPlayer.spell1[2]["damage"] as! Int
            defaultPlayer.health += heal
            for i in 0..<enemyList.count {
                let health = enemyList[i]["health"] as! Int
                let defend = enemyList[i]["defend"] as! Int
                let newHealth = health - damage + defend;
                enemyList[i]["health"] = newHealth;
                let playerhealth = defaultPlayer.health;
                let newplayerHealth = playerhealth + heal;
                if newplayerHealth > defaultPlayer.maxhealth{
                    defaultPlayer.health = defaultPlayer.maxhealth;
                }else{
                    defaultPlayer.health = newplayerHealth;
                }
                
                print ("self heal")
            };
        default:
            print("Invalid number")
        }
    case "water":
        switch number {
        case 1:
            print(defaultPlayer.spell2[0])
            for i in 0..<1 {
                let stack = enemyList[i]["poison"] as! Int
                enemyList[i]["stack"] = stack+2;
            };
        case 2:
            print(defaultPlayer.spell2[1])
            for i in 0..<enemyList.count {
                let stack = enemyList[i]["poison"] as! Int
                enemyList[i]["stack"] = stack+2;
            };
        case 3:
            print(defaultPlayer.spell2[2])
            for i in 0..<enemyList.count {
                let stack = enemyList[i]["poison"] as! Int
                let health = enemyList[i]["health"] as! Int
                let newHealth = health - (stack * poisonDamage);
                enemyList[i]["health"] = newHealth;
                print ("poision all enemies")
            };
        default:
            print("Invalid number")
        }
    case "wind":
        switch number {
        case 1:
            print(defaultPlayer.spell3[0])
            let shield = defaultPlayer.spell3[0]["shield"] as! Int
            defaultPlayer.shield += shield
        case 2:
            print(defaultPlayer.spell3[1])
            let shield = defaultPlayer.spell3[1]["shield"] as! Int
            defaultPlayer.shield += shield
        case 3:
            print(defaultPlayer.spell3[2])
            let shield = defaultPlayer.spell3[2]["shield"] as! Int
            defaultPlayer.shield += shield
            for i in 0..<enemyList.count {
                let speed = enemyList[i]["speed"] as! Int
                let newSpeed = speed + 1;
                enemyList[i]["speed"] = newSpeed;
                print ("slow all enemies");
            };
        default:
            print("Invalid number")
        }
    default:
        print("Invalid element")
    }
}

func endEnemyTurn(){
    if (enemyList.count == 0){
        print("next level")
    }
    print ("enemies status",enemyList,"playerstatus",defaultPlayer);
    for i in 0..<enemyList.count {
        let stack = enemyList[i]["poison"] as! Int
        let health = enemyList[i]["health"] as! Int
        let newHealth = health - (stack * poisonDamage);
        enemyList[i]["health"] = newHealth;
        print("take poison damage", stack * 10)
        if newHealth > 0 {
            let newstack = stack - 1;
            enemyList[i]["poison"] = newstack;
            let speed = enemyList[i]["speed"] as! Int
            let newSpeed = speed - 1;
            if newSpeed == 0 {
                enemyList[i]["speed"] = enemyList[i]["defaultSpeed"]
                let damage = enemyList[i]["attack"]as! Int
                if defaultPlayer.shield > damage{
                    defaultPlayer.shield -= damage;
                }
                else{
                    let takeDMG = damage - defaultPlayer.shield
                    defaultPlayer.health = - takeDMG
                    defaultPlayer.shield = 0
                }
                print("player take ",damage,"damage");
            }
            else{
                enemyList[i]["speed"] = newSpeed;
            }
        }else{
            let enemyList = enemyList.remove(at: i)
            print("the enemy ",i, "is dead")
        }
    };
}
