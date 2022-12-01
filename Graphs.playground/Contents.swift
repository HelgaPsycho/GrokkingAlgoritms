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


//типы ребер
public enum EdgeType {
    //направленные
    case directed
    //ненаправленные
    case undirected
}

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable{}

extension Vertex: CustomStringConvertible {
    public var description: String {
        "\(index): \(data)"
    }
}

public struct Edge<T> {
    public let sourse: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

public protocol Graph {
    
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from sourse: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    func add(_ edge: EdgeType,
             from sourse: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    func edges(from sourse: Vertex<Element>)-> [Edge<Element>]
    func weight(from sourse: Vertex<Element>, to destination: Vertex<Element>)->Double
}

    //Имплементировать граф можно с помощью списка либо матрицы

//ADJACENCY LIST
//для каждого узла графа граф храф хранит список ребер
//узел - ключ словаря, массив из ребер - значение словаря
/*
 ---------------------------------------------------------------
 Vertices       |  Adjacency list
 ---------------------------------------------------------------
 Singapore     ->  Tokyo  Hong Kong
 Hong Kong     ->  Tokyo  Singapore  Tokyo  San Francisco
 Tokyo         ->  Singapore  Detroit  Detroit  Washington DC
 Detroit       ->  Tokyo
 Washington DC ->  Tokyo San Francisco
 San Francisco ->  Hong Kong  Washington DC
 ----------------------------------------------------------------
 */



public class AdjacencyList<T: Hashable>: Graph {
   
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]

    public init() {}

    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    // protocol Graph

    public func addDirectedEdge(from sourse: Vertex<T>,
                         to destination: Vertex<T>,
                         weight: Double?) {
        let edge = Edge(sourse: sourse, destination: destination, weight: weight)
        adjacencies[sourse]?.append(edge)
    }
    
    public func edges(from sourse: Vertex<T>) -> [Edge<T>] {
        adjacencies[sourse] ?? []
        //возвращает массив из ребер, которые принадлежат данному узлу, либо пустой массив, если такой узел не известен
        
    }
    
    public func weight(from sourse: Vertex<T>, to destination: Vertex<T>) -> Double {
        return 2
    }
    

}

extension Graph {
    public func addUndirectedEdge(between source: Vertex<Element>,
                                  and destination: Vertex<Element>,
                                  weight: Double?){
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
        
    }
    
    
    public func add(_ edge: EdgeType, from sourse: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: sourse, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: sourse, and: destination, weight: weight)
            
        }
        
    }
}
