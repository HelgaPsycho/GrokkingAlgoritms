/* СОРТИРОВКА ВЫБОРОМ SELECTION SORT
 Key points:
 - Может перейти к алгоритму быстрой сортировки
 - Время О(n^2)
 */

//1 вариант

func selectionSorted (array: [Int]) -> [Int]{
    var oldArray: [Int] = array
    var newArray: [Int] = []
    for i in 1...array.count {
        //2.Повторяет цикл количество раз, равное количеству элементов в массиве
        let smallestIndex = findSmallestIndex(array: oldArray)
      //  3. Находим наименьший элемент в старом массиве и добавляем его в новый массив
        newArray.append(oldArray[smallestIndex])
        // 4. Удаляем его из старого массива
        oldArray.remove(at: smallestIndex)
        
    }
    // 1.Находим индекс наименьшего значения
    func findSmallestIndex (array: [Int]) -> Int  {
    var smallest = array[0]
    var smallestIndex = 0
        // наименьшему значению сначала присваиваем 0, поэтому цикл по индексам с 1:
    for i in 1..<(array.count) {
            if array[i] < smallest {
                smallest = array[i]
                smallestIndex = i
            }
        }
        return smallestIndex
}
    
return newArray
}

var array: [Int] =  [2, 5, 1, 9, 23, 5, 98, 2 ,1 ,7]

print(selectionSorted(array: array))

//2 вариант

func selectionSort <T: Comparable> (array: inout [T]) {
    guard array.count > 1 else { return}
    for current in 0..<(array.count - 1) {
        var lowest = current
        for other in (current+1)..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        
        }
        if lowest != current {
            array.swapAt(lowest, current)
        }
    }
    
}

selectionSort(array: &array)
print(array)

