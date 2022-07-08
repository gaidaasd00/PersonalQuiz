//
//  Question.swift
//  PersonalQuiz
//
//  Created by Алексей Гайдуков on 08.07.2022.
//

struct Questin {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
   static func getQuestions() -> [Questin] {
        [
            Questin(title: "Какую пищу вы предпочитаете?",
                    responseType: .single,
                    answers: [
                        Answer(title: "Стейк", animal: .dog),
                        Answer(title: "Рыба", animal: .cat),
                        Answer(title: "Морковь", animal: .rabbit),
                        Answer(title: "Кукуруза", animal: .turtle)
                    ]
                   ),
            Questin(title: "Что вам нравиться больше?",
                    responseType: .multipal,
                    answers: [
                        Answer(title: "Плавать", animal: .dog),
                        Answer(title: "Спать", animal: .cat),
                        Answer(title: "Обниматься", animal: .rabbit),
                        Answer(title: "Есть", animal: .turtle)
                    ]
                   ),
            Questin(title: "Любите ли вы поездки на машине?",
                    responseType: .ranged,
                    answers: [
                        Answer(title: "Ненавижу", animal: .cat),
                        Answer(title: "Нервничаю", animal: .rabbit),
                        Answer(title: "Не замечаю", animal: .rabbit),
                        Answer(title: "Обожаю", animal: .dog)
                    ]
                   )
            
        ]
    }
}

enum ResponseType {
    case single
    case multipal
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐕‍🦺"
    case cat = "🐈"
    case rabbit = "🐇"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравяться и всегда готовы помочь!"
        case .cat:
            return "Вы сами себе на уме. Любите гулять сами по себе. Любите одиночесво"
        case .rabbit:
            return "Вам нравится всё мягкое. Вы здоровы и полны энергии"
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях"
        }
    }
}
