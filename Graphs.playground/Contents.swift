/*
 ГРАФ
 - структура, моделирующая набор связей. состоит из узлов и ребер
  ______               ______
 | УЗЕЛ | ---РЕБРО--> | УЗЕЛ |
  ------               ------
 - узел может быть соединнен с неколькими узлами  "соседями"
 
 ПОИСК В ШИРИНУ
 отвечает на 2 вопроса
 1 - существует ли путь от узла А к узлу В
 2 - как выглядит кратчаший путь от узла А к узлу В
 
 Связи делятся на связи:
 1го уровня
 2го уровня ...
 
 Вначале должны проверятся все связи первого уровня
 Связи проверяются в порядке их добавления, это помогает осуществить очередь
 
 ОЧЕРЕДЬ
 структура FIFO - first input first output
 операции:
 - постановка в очередь
 - извлечение из очереди
 
 РЕАЛИЗАЦИЯ ГРАФА
 отношения между узлами можно выразить с помощью хэш - таблицы
 ключ - значение  == узел - соседи

 */
var graph = [String: [String]]()
graph["You"] = ["Alice", " Bob", "Claire"]
graph["Bob"] = ["Peggi", "Anuge"]
graph["Claire"] = ["Jonny", "Tom"]
graph["Alice"] = ["Peggi"]
graph["Peggi"] = []
graph["Anuge"] = []
graph["Jonny"] = []
graph["Tom"] = []

/* ВИДЫ ГРАФОВ:
 
НАПРАВЛЕННЫЕ - отношения действуют только в одну сторону
  ____         ________
 |Росс|-----> | Рейчел |
  ----         --------
 
 НЕНАПРАВЛЕННЫЕ
 ____          ________
|Росс|--------| Рейчел |
 ----          --------
 
 РЕАЛИЗАЦИЯ АЛГОРИТМА ПОИСКА В ШИРИНУ
 1. Создать очередь с именами проверяемых людей
 2. Извлечь из очереди очередного человек
 3. Проверить является ли этот человек искомым -> нашли -> завершение поиска
 4. Добавить всех соседей этого человека в очередь
 5. Цикл продолжается
 6. Если очередь пуста, то в сети нет искомого объекта
 
 ДВУСТОРОННЯЯ ОЧЕРЕДЬ (ДЕКА) DEQUE
- абстрактный тип данных, в котором можно добавлять и удалаять элементы как вначале так и в конец. Может быть реализована с помощью двусвязнного

*/

//struct Friend: Hashable {
//    let isSellerOfMango: Bool
//
//    init(){
//        self.isSellerOfMango = false
//    }
//
//    init(isSellerOfMango: Bool){
//        self.isSellerOfMango = isSellerOfMango
//    }
//
//
//}
//
//let iAm = Friend()
//let alice = Friend()
//let bob = Friend()
//let peggi = Friend()
//let anudge = Friend()
//let clar = Friend()
//let jonny = Friend(isSellerOfMango: true)
//let tom = Friend()
//
//var newGraph = [Friend: [Friend]]()
//newGraph[iAm] = [alice, bob, clar]
//newGraph[alice] = [peggi]
//newGraph[bob] = [peggi, anudge]
//newGraph[clar] = [tom, jonny]
////newGraph[anudge] = []
////newGraph[peggi] = []
////newGraph[jonny] = []
////newGraph[tom] = []
//
//print(newGraph)
//
//var queue: [Friend] = newGraph[iAm]!
//
//print(queue)
//
//while queue.isEmpty == false {
//    if queue[0].isSellerOfMango {
//        print ("\(queue[0]) is seller of mango")
//
//    } else {
//        queue.append(contentsOf: newGraph[queue[0]]!)
//        queue.dropFirst()
//    }
//}
//
//

class Man {
    let name: String
    let isSellerOfAvocado: Bool
    
    init (name: String){
        self.name = name
        self.isSellerOfAvocado = false
    }
    
    init (name: String, isSellerOfAvocado: Bool){
        self.name = name
        self.isSellerOfAvocado = isSellerOfAvocado
    }
    // при создании структуры swift с переменной в виде массиса, не сохранняются изменения в этом массиве
    var friends: [Man] = []
}

var you = Man(name: "You")
var bob = Man(name: "Bob")
var alice = Man(name: "Alice")
var claire = Man(name: "Claire")
var anuj = Man(name: "Anuj")
var peggy = Man(name: "Peggy")
var tom = Man(name: "Tom", isSellerOfAvocado: true)
var jonny = Man(name: "Jonny")

you.friends.append(contentsOf: [alice, bob, claire])
bob.friends = [anuj, peggy]
alice.friends = [peggy]
claire.friends = [tom, jonny]

var queue: [Man] = you.friends //1. Создать очередь с именами проверяемых людей
    
    while queue.isEmpty == false  { //5. Цикл продолжается
        var firstElement = queue.removeFirst() // 2. Извлечь из очереди очередного человек
        if firstElement.isSellerOfAvocado == true {
            //3. Проверить является ли этот человек искомым -> нашли -> завершение поиска
            print("\(firstElement.name) is a seller of avocado")
        } else {
            queue = queue + firstElement.friends // 4. Добавить всех соседей этого человека в очередь
            // print("The queue is \(queue)")
            
        }
    }



