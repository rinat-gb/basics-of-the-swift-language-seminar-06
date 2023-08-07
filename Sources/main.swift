// Задание
// -----------------------------------------------------------------------
// 1. Создать структуру работника пиццерии.
// В ней должны быть такие свойства, как имя, зарплата и должность.
// Должностей пока может быть две: или кассир, или повар.
// Добавить в класс пиццерии массив с работниками

// 2. Создать класс столика,
// в нем должны быть свойство, в котором содержится количество мест и функция,
// которая на вход принимает количество гостей, которое хотят посадить,
// а возвращает true, если места хватает и false, если места не хватает.
// Изначальное количество мест задается в инициализаторе

// 3. Добавить в класс пиццерии свойство, в котором хранится массив столиков.
// У класса столика добавить свойство, в котором хранится пиццерия, в которой стоит столик.
// Столики создаются сразу в инициализаторе, не передаются туда в качестве параметра

// Выполнение задания
// -----------------------------------------------------------------------
// 1. Создать структуру работника пиццерии.
// В ней должны быть такие свойства, как имя, зарплата и должность.
// Должностей пока может быть две: или кассир, или повар.
// Добавить в класс пиццерии массив с работниками

// работник пиццерии
struct Employee {
    // возможные должности
    enum Position: String {
        case Teller = "кассир"
        case Cook = "повар"

        func getPosition() -> String { rawValue }
    }

    var name: String
    var salary: Double
    var position: Position
}

// -----------------------------------------------------------------------
// 2. Создать класс столика,
// в нем должны быть свойство, в котором содержится количество мест и функция,
// которая на вход принимает количество гостей, которое хотят посадить,
// а возвращает true, если места хватает и false, если места не хватает.
// Изначальное количество мест задается в инициализаторе
class Table {
    let numOfSeats: Int

    // 3. У класса столика добавить свойство, в котором хранится пиццерия, в которой стоит столик.
    weak var pizzeria: Pizzeria

    init(numOfSeats: Int, pizzeria: Pizzeria) {
        self.numOfSeats = numOfSeats
        self.pizzeria = pizzeria
    }

    public func guestsAvailable(numOfGusts: Int) -> Bool { numOfSeats <= numOfGusts }
}

// Предыдущее задание с учётом изменений из текущего
// -----------------------------------------------------------------------
// это класс пиццерии и всё что к нему относится из предыдущего занятия
//
struct Pizza {
    enum PizzaKind: String {
        case Pepperoni = "Пепперони"
        case ChetyreSyra = "4 сыра"
        case Barbeku = "Барбекю"
        case Diablo = "Дьябло"

        func getPizzaName() -> String { rawValue }
    }

    enum Additions: String {
        case Tomatoes = "помидоры"
        case Sausage = "колбаса"
        case Pepper = "перец"
        case Cheese = "сыр"

        func getAdditionName() -> String { rawValue }
    }

    mutating func addAddition(addition: Additions) {
        additions.append(addition)
    }

    var pizzaKind: PizzaKind
    var additions: [Additions] = []
    var isTestoTonkoe: Bool
}

class Pizzeria {
    private var pizzas: [Pizza]

    // 1. Добавить в класс пиццерии массив с работниками
    private var employees: [Employee]

    // 3. Добавить в класс пиццерии свойство, в котором хранится массив столиков.
    private var tables: [Table] = []

    init(pizzas: [Pizza], employees: [Employee]) {
        self.pizzas = pizzas
        self.employees = employees

        // 3. Столики создаются сразу в инициализаторе, не передаются туда в качестве параметра
        tables = [Table(numOfSeats: 2, pizzeria: self),
                  Table(numOfSeats: 4, pizzeria: self),
                  Table(numOfSeats: 3, pizzeria: self)]
    }

    public var description: String {
        var res = "Список всех пиц в пиццерии:"

        // выводим список всех пицц в данной пиццериии
        for (num, pizza) in pizzas.enumerated() {
            res += "\n" + String(num + 1) + ". " + pizza.pizzaKind.getPizzaName()

            if pizza.isTestoTonkoe {
                res += ", тонкое тесто"
            } else {
                res += ", толстое тесто"
            }

            if pizza.additions.isEmpty {
                res += ", стандартная"
            } else {
                res += ", с дополнениями:"

                for addition in pizza.additions {
                    res += "\n\t" + addition.getAdditionName()
                }
            }
        }
        return res
    }

    // функция добавления пиццы
    func addPizza(pizza: Pizza) {
        pizzas.append(pizza)
    }
}
