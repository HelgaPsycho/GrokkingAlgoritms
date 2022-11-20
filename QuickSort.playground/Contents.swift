/*
 БЫСТРАЯ СОРТИРОВКА
 - основана на рекурсии и принципе "разделяй и властвуй"
 
 Шаги метода РАЗДЕЛЯЙ и ВЛАСТВУЙ:
 - Сначала определяется базовый случай. Это должен быть простейший случай из всех возможных. При работе с массивом это чаще всего пустой массив или массив с одним элементом.
 - Задача делится и сокращается до тех пор, пока не будет сведена к базовому случаю
 
 Алгоритм Евклида (эффективный алгоритм для нахождения наибольшего общего делителя двух целых чисел (или общей меры двух отрезков)) основан на принципе "разделяй и властвуй"
 */

/* ЗАДАЧА - СУММА чисел массива
можно решить:
 - c помощью цикла
 - с помощью рекусии
*/
//ЦИКЛ:

func sum1(array: [Int]) -> Int {
var total = 0
for i in array {
    total += i
}
    return total
}

print(sum1(array: [6,2,3]))

//РЕКУРСИЯ:
//базовый случай - когда число элементов равно 0 или 1
//каждый рекурсивный вызов должен уменьшать размер массива (результат равен сумме первого числа в списке и суммы остального массива)

func sum(array: [Int]) -> Int{
   if array.count < 2 {
        return array[0]
    } else {
        return array[0] + sum(array: [Int](array.dropFirst()))
    }
}

print (sum(array: [6, 3, 7, 3, 9, 12]))


func factorial(x: Int) -> Int {
    if x == 1 {
        return 1
    } else {
        return x * factorial(x: (x - 1))
    }
}

print(factorial(x: 5))

//УПРАЖНЕНИЯ
// 1. Напишите код для функции sum.

func sum3 (array: [Int]) -> Int{
   if array.count < 2 {
        return array[0]
    } else {
        return array[0] + sum3(array: [Int](array.dropFirst()))
    }
}

print (sum(array: [6, 3, 7, 3, 9, 12]))

// 2.Напишите рекурсивную функцию для подсчета элементов в списке.

func numberOfElements(array: [Int], counter: Int = 0) -> Int {
    var count = counter
    if array.isEmpty {
        return counter
    }
    else {
        count += 1
        return numberOfElements(array: array.dropLast(), counter: count)
    }
}

print(numberOfElements(array: [5, 6, 2, 8, 34, 6]))

// 3. Найдите наибольшее число в списке.

func findMaxElement(array: [Int], maxElement: Int = Int.min) -> Int {
    var arr = array
    var max = maxElement
    if array.count == 1{
        if max > array[0] {
            return max
        } else {
            return array[0]
        }
    } else {
        let current = arr.removeLast()
        if current > max {
            max = current
        }
    }
    return findMaxElement(array: arr, maxElement: max)
    
}

print(findMaxElement(array: [7, 0, 3, 18, 3 ,19, 2]))

//4. Помните бинарный поиск из главы 1? Он тоже относится к классу ал- горитмов «разделяй и властвуй». Сможете ли вы определить базовый и рекурсивный случай для бинарного поиска?

// базовый случай - миссив, содержащий 1 элемент, рекурсивный - половина массива, по которой проводится поиск


/*БЫСТРАЯ СОРТИРОВКА QUICK SORT
 - основана на рекурсии и принципе "разделяй и властвуй"
 - базовый случай, когда в массиве меньше 2-х элементов
 - массив из 2-х элементов тоже легко сортируется
 - рекурсивный случай, когда элементов 3 и более
 - выбирается опорный элемент (pivot), например первый элемент массива
 - находим элементы меньше опорного, равные опорному и меньше опорного
 
 */

func quickSort(array: [Int]) -> [Int] {
    var less: [Int] = []
    var greaterOrEqual: [Int] = []
    if array.count < 2 {
        //базовый случай
        return array
    } else {
        let pivot = array[0]
        for i in 1..<array.count {

            if array[i] < pivot {
                less.append(array[i])
            } else if  array[i] >= pivot {
                greaterOrEqual.append(array[i])
            }

        }
        return quickSort(array: less) + quickSort(array: [pivot]) + quickSort(array: greaterOrEqual)
    }

}

print(quickSort(array: [3, 1, 8, 4, 5, 9, 11]))


func quicksort<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }

  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }

  return quicksort(less) + equal + quicksort(greater)
}

print(quicksort([4, 1, 820, 45, 1, 4, 6,2, 67]))
