import Foundation

struct ContentDatabase {
    static let questTemplates: [String: [String: [QuestTemplate]]] = [
        "algebra": [
            "Квадратные уравнения": [
                QuestTemplate(title: "Квест: Дискриминант в действии", desc: "Реши в тетради: x² - 5x + 6 = 0. Найди корни.", xp: 50, coins: 20, type: "notebook", diff: 1),
                QuestTemplate(title: "Квест: Теорема Виета", desc: "x² + 3x - 10 = 0. Сумма корней? Произведение? Пиши в тетрадь.", xp: 60, coins: 25, type: "notebook", diff: 2),
                QuestTemplate(title: "Квест: График параболы", desc: "Построй схему графика y = -x² + 4x - 3. Вершина? Ветви?", xp: 70, coins: 30, type: "notebook", diff: 2)
            ],
            "Неравенства": [
                QuestTemplate(title: "Квест: Интервальный метод", desc: "Реши неравенство: (x-2)(x+3) > 0. Ответ запиши через объединение интервалов.", xp: 80, coins: 35, type: "notebook", diff: 2)
            ]
        ],
        "physics": [
            "Законы Ньютона": [
                QuestTemplate(title: "Квест: Сила трения", desc: "Тело 5 кг движется равномерно. μ = 0.2. Найди силу трения. g=10. Ответ в Н.", xp: 50, coins: 20, type: "quiz", diff: 1, answer: "10"),
                QuestTemplate(title: "Квест: Второе закон", desc: "На тело 2 кг действует сила 20 Н. Какое ускорение? Ответ в м/с².", xp: 50, coins: 20, type: "quiz", diff: 1, answer: "10"),
                QuestTemplate(title: "Квест: Лаба в тетради", desc: "Опиши опыт: 'Определение коэффициента трения скольжения'. Рисунок, ход работы, вывод.", xp: 100, coins: 50, type: "notebook", diff: 3)
            ]
        ],
        "geometry": [
            "Векторы": [
                QuestTemplate(title: "Квест: Сложение векторов", desc: "Даны векторы a(3, 2) и b(-1, 5). Найди координаты вектора a + b. Пиши в тетрадь.", xp: 60, coins: 25, type: "notebook", diff: 1),
                QuestTemplate(title: "Квест: Длина вектора", desc: "Вектор c(6, 8). Найди его длину. Ответ: число.", xp: 50, coins: 20, type: "quiz", diff: 1, answer: "10")
            ]
        ],
        "chemistry": [
            "Электролиз": [
                QuestTemplate(title: "Квест: Законы Фарадея", desc: "Рассчитай массу меди, выделившейся на катоде при прохождении тока 2А за 30 мин. ЭПС Cu=63.5. Ответ в граммах (целое).", xp: 80, coins: 40, type: "quiz", diff: 2, answer: "2")
            ]
        ]
    ]
    
    static func generateStubQuests(for subject: String, count: Int = 3) -> [QuestTemplate] {
        let titles = ["Разведка локации", "Сбор артефактов", "Аномалия знаний", "Лагер у костра", "Патруль периметра"]
        return (0..<count).map { i in
            QuestTemplate(
                title: "\(titles[i % titles.count]) (\(subject.capitalized))",
                desc: "Заглушка: Прочитай параграф или реши 3 примера из учебника в тетради. Нажми 'Готово' после выполнения.",
                xp: 40, coins: 15, type: "notebook", diff: 1
            )
        }
    }
    
    struct QuestTemplate {
        let title: String
        let desc: String
        let xp: Int
        let coins: Int
        let type: String
        let diff: Int
        let answer: String?
        
        init(title: String, desc: String, xp: Int, coins: Int, type: String, diff: Int, answer: String? = nil) {
            self.title = title
            self.desc = desc
            self.xp = xp
            self.coins = coins
            self.type = type
            self.diff = diff
            self.answer = answer
        }
    }
}