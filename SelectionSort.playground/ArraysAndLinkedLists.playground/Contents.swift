/*
 Связанный список
 - В связанном списке каждый элемент имеет сслыку на следующий элемент
 - Подходит для: вставки/удаления новых объектов О(1), последовательного чтения элементов
 - Не подходит для: чтения элементов в произвольных позициях O(n) (возможен только последовательный доступ)
 
 Массив
 - Элементы массива пронумерованы индексами (с нуля пости во всех языках)
 - Подходит для: чтения элементов на произвольных позициях O(1), последовательного чтения элементов
 - Не подходит для: вставки/удаления новых объектов О(n)
 
 Доступ к эелементам (чтение):
 - последовательный (в связаннном списке)
 - произвольный (в массиве)
 
 
 ОПЕРАЦИИ -> подходящая структура данных
 - вставка в середину списка -> связанный список O(1)
 - удаление -> связанный список O(1)
 - чтение -> массив О(1)
 
 Но при этом для вставки/удаления в связанном списке нужно сначала найти элемент - O(n)
 
 НА ПРАКТИКЕ чаще используется массив.
 
 УПРАЖНЕНИЯ
 1. Допустим, вы строите приложение для управления финансами. Ежедневно вы записываете все свои траты. В конце месяца вы анали- зируете расходы и вычисляете, сколько денег было потрачено. При работе с данными выполняется множество операций вставки и отно- сительно немного операций чтения. Какую структуру использовать — массив или список?
 
 связанный список
 
 2. Допустим, вы пишете приложение для приема заказов от посетителей ресторана. Приложение должно хранить список заказов. Официанты добавляют заказы в список, а повара читают заказы из списка и вы- полняют их. Заказы образуют очередь: официанты добавляют заказы в конец очереди, а повар берет первый заказ из очереди и начинает готовить. Какую структуру данных вы бы использовали для реализации этой очереди: массив или связанный список? (Подсказка: связанные списки хорошо подходят для вставки/удаления, а массивы — для произволь- ного доступа к элементам. Что из этого понадобится в данном случае?)
 
 связанный список
 
 3. Проведем мысленный эксперимент. Допустим, Facebook хранит список имен пользователей. Когда кто-то пытается зайти на сайт Facebook, система пытается найти имя пользователя. Если имя входит в список имен зарегистрированных пользователей, то вход разреша- ется. Пользователи приходят на Facebook достаточно часто, поэтому поиск по списку имен пользователей будет выполняться часто. Будем считать, что Facebook использует бинарный поиск для поиска в спи- ске. Бинарному поиску необходим произвольный доступ — алгоритм должен мгновенно обратиться к среднему элементу текущей части списка. Зная это обстоятельство, как бы вы реализовали список поль- зователей: в виде массива или в виде связанного списка?
 
 отсортированный массив
 
 4. Пользователи также довольно часто создают новые учетные записи на Facebook. Предположим, вы решили использовать массив для хране- ния списка пользователей. Какими недостатками обладает массив для выполнения вставки? Допустим, вы используете бинарный поиск для нахождения учетных данных. Что произойдет при добавлении новых пользователей в массив?
 
  массиву требуется отсортировать элементы для выполнения бинарного поиска
 
 5. В действительности Facebook не использует ни массив, ни связанный список для хранения информации о пользователях. Рассмотрим ги- бридную структуру данных: массив связанных списков. Имеется мас- сив из 26 элементов. Каждый элемент содержит ссылку на связанный список. Например, первый элемент массива указывает на связанный список всех имен пользователей, начинающихся на букву «A». Второй элемент указывает на связанный список всех имен пользователей, на- чинающихся на букву «B», и т. д.
 Предположим, пользователь с именем «Adit B» регистрируется на Facebook и вы хотите добавить его в список. Вы обращаетесь к эле- менту 1 массива, находите связанный список элемента 1 и добавляете «Adit B» в конец списка. Теперь предположим, что зарегистрировать нужно пользователя «Zakhir H». Вы обращаетесь к элементу 26, ко- торый содержит связанный список всех имен, начинающихся с «Z», и проверяете, присутствует ли «Zakhir H» в этом списке.
 Теперь сравните эту гибридную структуру данных с массивами и свя- занными списками. Будет ли она быстрее или медленнее каждой ис- ходной структуры при поиске и вставке? Приводить «O-большое» не нужно, просто выберите одно из двух: быстрее или медленнее.

 будет по скорости соответствовать лимитирующими структурами
 - Поиск медленее, чем для массивов и быстрее, чем для списков
 - Вставка как для связанных списков О(1)
 
 */
 

