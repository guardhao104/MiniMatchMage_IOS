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
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            let damage = defaultPlayer.spell1[0]["damage"] as! Int
            for i in 0..<1 {
                let health = enemyList[i]["health"] as! Int
                let defend = enemyList[i]["defend"] as! Int
                let newHealth = health - damage + defend;
                enemyList[i]["health"] = newHealth;
            };
        case 2:
            print(defaultPlayer.spell1[1])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            let damage = defaultPlayer.spell1[1]["damage"] as! Int
            for i in 0..<1 {
                let health = enemyList[i]["health"] as! Int
                let defend = enemyList[i]["defend"] as! Int
                let newHealth = health - damage + defend;
                enemyList[i]["health"] = newHealth;
            };
        case 3:
            print(defaultPlayer.spell1[2])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
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
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            for i in 0..<1 {
                let poison = enemyList[i]["poison"] as! Int
                enemyList[i]["poison"] = poison + 2;
            };
        case 2:
            print(defaultPlayer.spell2[1])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            for i in 0..<enemyList.count {
                let poison = enemyList[i]["poison"] as! Int
                enemyList[i]["poison"] = poison + 2;
            };
        case 3:
            print(defaultPlayer.spell2[2])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            for i in 0..<enemyList.count {
                let poison = enemyList[i]["poison"] as! Int
                let health = enemyList[i]["health"] as! Int
                enemyList[i]["poison"] = poison + 2
                let newHealth = health - (enemyList[i]["poison"] as! Int * poisonDamage);
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
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            let shield = defaultPlayer.spell3[0]["shield"] as! Int
            defaultPlayer.shield += shield
        case 2:
            print(defaultPlayer.spell3[1])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
            let shield = defaultPlayer.spell3[1]["shield"] as! Int
            defaultPlayer.shield += shield
        case 3:
            print(defaultPlayer.spell3[2])
            // trigger mage attack animation
            mageObj.startPlayerAttackAnimation()
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
    
    var newEnemyList = [Int]()
    // check for next level
    if (enemyList.count == 0){
        print("next level")
    }
    print ("enemies status",enemyList,"playerstatus",defaultPlayer.health,defaultPlayer.shield);
    // action for each enemy
    for i in 0..<enemyList.count {
        print ("debug before fatal error",enemyList,"count",enemyList.count,"this is i ",i);
        
        let poison = enemyList[i]["poison"] as! Int
        let health = enemyList[i]["health"] as! Int
        let newHealth = health - (poison * poisonDamage);
        // enemy take poison dmg
        print("take poison damage", poison ,poison * poisonDamage)
        // check if target enemy still alive
        if newHealth > 0 {
            enemyList[i]["health"] = newHealth;
            // poison stack reduce
            if poison > 0 {
                let newPoisonStack = poison - 1
                enemyList[i]["poison"] = newPoisonStack;
                // trigger enemy hit animation
                enemyArr[i].startHitAnimation()
            }
            // check enemy speed for attack
            let speed = enemyList[i]["speed"] as! Int
            let newSpeed = speed - 1;
            if newSpeed == 0 {
                enemyList[i]["speed"] = enemyList[i]["defaultSpeed"]
                // trigger enemy attack animation
                enemyArr[i].startAttackAnimation()
                let damage = enemyList[i]["attack"]as! Int
                // check player took dmg
                if defaultPlayer.shield > damage{
                    defaultPlayer.shield -= damage;
                }
                else{
                    let takeDMG = damage - defaultPlayer.shield
                    defaultPlayer.health = defaultPlayer.health - takeDMG
                    defaultPlayer.shield = 0
                    // trigger mage hit animation
                    mageObj.startPlayerHitAnimation()
                }
                print("player take ",damage,"damage");
            }
            else{
                enemyList[i]["speed"] = newSpeed;
            }
        }else{
            enemyList[i]["health"] = 0;
            newEnemyList.append(i)
        }
    };
    newEnemyList.sort(by: >)
    for j in newEnemyList{
        enemyList.remove(at: j)
        print("the enemy ",newEnemyList, "is dead !!!!" )
    }
}
