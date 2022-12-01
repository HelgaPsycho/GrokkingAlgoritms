//РЕАЛИЗАЦИЯ ГРАФА ЧЕРЕЗ СЛОВАРЬ
// ADJACENCY LIST

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
    func weight(from sourse: Vertex<Element>, to destination: Vertex<Element>)->Double?
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
    
    public func weight(from sourse: Vertex<T>, to destination: Vertex<T>) -> Double? {
        (edges(from: sourse).first{ $0.destination == destination }?.weight)
        //находим первое ребро от узла до узла и если оно одно, возвращаем его вес
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

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (vertex, edges) in adjacencies { //1 петля через каждую пару ключ-значение для adjacencies
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                //2 для каждого узла петли через все выходящие ребра и добавляем значение в строку
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [\(edgeString) ] \n") //3 для каждого узла  распечатываем узел и все исходящие ребра
        }
            return result
    }
}
//Создаем граф
let graphByList = AdjacencyList<String> ()

// Добавляем узлы
let singapore = graphByList.createVertex(data: "Singapore")
let tokyo = graphByList.createVertex(data: "Tokyo")
let hongKong = graphByList.createVertex(data: "Hong Kong")
let detroit = graphByList.createVertex(data: "Detroit")
let sanFrancisco = graphByList.createVertex(data: "San Francisco")
let washingtonDC = graphByList.createVertex(data: "Washington DC")
let austinTexas = graphByList.createVertex(data: "Austin Texas")
let seattle = graphByList.createVertex(data: "Seattle")

//добавляем ребра и их стоимости
graphByList.add(.undirected, from: singapore, to: hongKong, weight: 300)
graphByList.add(.undirected, from: singapore, to: tokyo, weight: 500)
graphByList.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graphByList.add(.undirected, from: tokyo, to: detroit, weight: 450)
graphByList.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graphByList.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graphByList.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graphByList.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graphByList.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graphByList.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graphByList.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graphByList.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(graphByList)

//OUTPUT:
//4: San Francisco ---> [2: Hong Kong, 5: Washington DC, 7: Seattle, 6: Austin Texas ]
//5: Washington DC ---> [1: Tokyo, 6: Austin Texas, 4: San Francisco, 7: Seattle ]
//7: Seattle ---> [5: Washington DC, 4: San Francisco ]
//6: Austin Texas ---> [3: Detroit, 5: Washington DC, 4: San Francisco ]
//0: Singapore ---> [2: Hong Kong, 1: Tokyo ]
//2: Hong Kong ---> [0: Singapore, 1: Tokyo, 4: San Francisco ]
//1: Tokyo ---> [0: Singapore, 2: Hong Kong, 3: Detroit, 5: Washington DC ]
//3: Detroit ---> [1: Tokyo, 6: Austin Texas ]

//Можно получить ответы на вопросы:

// Сколько стоит полет из Сингапура в Токио?
print(graphByList.weight(from: singapore, to: tokyo))
//OTPUT:
//Optional(500.0)

//Какие рейсы из Сан Франциско?
print("San Francisco Otgoing Flights:")
print("-------------------------------")
for edge in graphByList.edges(from: sanFrancisco){
    print ("from: \(edge.sourse) to: \(edge.destination)")
}

