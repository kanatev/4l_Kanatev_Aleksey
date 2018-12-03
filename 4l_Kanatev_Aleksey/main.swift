//
//  main.swift
//  4l_Kanatev_Aleksey
//
//  Created by AlexMacPro on 02/12/2018.
//  Copyright © 2018 AlexMacPro. All rights reserved.
//

import Foundation

enum EngineState { // перечисляем состояния двигателя
    case on, off, onWhileCold, afterburner
}

enum WindowState { // перечисляем состояния окон
    case open, close, withoutGlasses
}

class Car { // создаем класс с описанием автомобиля
    var carBrand: String // создаем свойство с маркой авто
    var carModel: String // создаем свойство с моделью авто
    var releaseYear: Int // создаем свойство с годом выпуска авто
    var carEngineState: EngineState { // создаем свойство о состоянии двигателя с наблюдателем изменений
        didSet { // выполнится после присвоения нового значения свойству isEngineOn
            if carEngineState == .on {
                print("Двигатель включен")
            } else if carEngineState == .off {
                print("Двигатель выключен")
            } else if carEngineState == .afterburner {
                print("Двигатель включен в режим ФОРСАЖ")
            } else {
                print("Двигатель будет включен пока не нагреется")
            }
        }
    }
    var carWindowState: WindowState { // создаем свойство о состоянии окон с наблюдателем изменений
        willSet { // выполнится перед присвоением нового значения свойству carWindowState
            if newValue == .open {
                print("Открываем окна")
            } else if newValue == .close {
                print("Закрываем окна")
            }
            else {
                print("Сейчас удалим стекла")
            }
        }
    }

    
    func changeEngineState(_ state: EngineState) { // добавляем метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
        self.carEngineState = state
    }
    init(carBrand: String, carModel: String, releaseYear: Int, carEngineState: EngineState, carWindowState: WindowState){
        self.carBrand = carBrand
        self.carModel = carModel
        self.releaseYear = releaseYear
        self.carEngineState = carEngineState
        self.carWindowState = carWindowState
    }
}


class TrunkCar: Car {
    
    enum BackDoorState {
        case open, close
    }
        override func changeEngineState(_ state: EngineState) { // перегружаем метод под нужды подкласса trunkCar
            if self.backDoorState != .open {
                self.carEngineState = state
            } else {
                print("Включать и выключать двигатель можно только с закрытой задней дверью кузова.")
            }
        }
    
    var backDoorState: BackDoorState
    
        var cargoCapacity: Int // создаем свойство с данными об объеме багажника
        var cargoLoadCurrent: Int // создаем свойство с информацией о текущей загрузке багажника в литрах
        var cargoLoadPerCent: Int { // создаем ВЫЧИСЛЯЕМОЕ свойство для подсчета процента текущей загрузки багажника, а также для вычисления текущей загрузки в литрах при изменении объема загрузки багажника в процентах.
            get { // принимаемое значение для свойства trunkStatePerCent
                return Int(Double(cargoLoadCurrent) / Double(cargoCapacity) * 100)
            }
            set { // влияние на другие свойства структуры. В данном случае влияем на текущий объем загрузки в литрах.
                cargoLoadCurrent = newValue * cargoCapacity / 100
            }
        }
    
        init(carBrand: String, carModel: String, releaseYear: Int, carEngineState: EngineState, carWindowState: WindowState, backDoorState: BackDoorState, cargoCapacity: Int, cargoLoadCurrent: Int){
                self.backDoorState = backDoorState
                self.cargoCapacity = cargoCapacity
                self.cargoLoadCurrent = cargoLoadCurrent
                super.init(carBrand: carBrand, carModel: carModel, releaseYear: releaseYear, carEngineState: carEngineState, carWindowState: carWindowState)
        }
    }

var trunkCar1 = TrunkCar(carBrand: "Mercedes", carModel: "Actros", releaseYear: 2015, carEngineState: .off, carWindowState: .close, backDoorState: .close, cargoCapacity: 10000, cargoLoadCurrent: 7000)
var trunkCar2 = TrunkCar(carBrand: "Scania", carModel: "G400", releaseYear: 2017, carEngineState: .off, carWindowState: .close, backDoorState: .close, cargoCapacity: 13000, cargoLoadCurrent: 8000)
var trunkCar3 = TrunkCar(carBrand: "Man", carModel: "TGM", releaseYear: 2016, carEngineState: .off, carWindowState: .close, backDoorState: .close, cargoCapacity: 6800, cargoLoadCurrent: 5000)

trunkCar1.cargoLoadCurrent = 8000
trunkCar1.backDoorState = .open
print("Проверяем отработку наблюдателя изменений в свойстве carWindowState:")
trunkCar2.carWindowState = .withoutGlasses
trunkCar3.cargoLoadCurrent = 6700


class SportCar: Car {
    
    enum HatchState { // делаем перечисление вложенным типом
        case open, close
    }
    
    override func changeEngineState(_ state: EngineState) { // перегружаем метод под нужды подкласса SportCar
        if self.hatchState != .open {
            self.carEngineState = state
        } else {
            print("Операция отклонена. Включать и выключать двигатель можно только с закрытым люком.")
        }
    }
    
    

    var maxSpeed: Int
    var hatchState: HatchState
    
    init(carBrand: String, carModel: String, releaseYear: Int, carEngineState: EngineState, carWindowState: WindowState, maxSpeed: Int, hatchState: HatchState){
        self.maxSpeed = maxSpeed
        self.hatchState = hatchState
        super.init(carBrand: carBrand, carModel: carModel, releaseYear: releaseYear, carEngineState: carEngineState, carWindowState: carWindowState)
    }
}
var sportCar1 = SportCar(carBrand: "Bugatti", carModel: "Chiron", releaseYear: 2016, carEngineState: .off, carWindowState: .close, maxSpeed: 420, hatchState: .open)
var sportCar2 = SportCar(carBrand: "McLaren", carModel: "Speedtail", releaseYear: 2019, carEngineState: .off, carWindowState: .close, maxSpeed: 403, hatchState: .open)
var sportCar3 = SportCar(carBrand: "Lamborghini", carModel: "Huracan", releaseYear: 2016, carEngineState: .off, carWindowState: .close, maxSpeed: 340, hatchState: .open)


print("\nПроверяем отработку наблюдателя изменений в свойстве carEngineState:")
sportCar1.carEngineState = .on
sportCar1.carEngineState = .off

print("\nПроверяем работу enum hatchState:")
sportCar1.hatchState = .close
print(sportCar1.hatchState)
sportCar1.hatchState = .open
print(sportCar1.hatchState)

print("\nПроверяем отработку перегруженного метода carEngineState в подклассе SportCar:")
sportCar1.changeEngineState(.on)

print("\ntrunkCar1 имеет следующие характеристики: \nМарка: \(trunkCar1.carBrand), \nМодель: \(trunkCar1.carModel), \nГод выпуска: \(trunkCar1.releaseYear), \nГрузоподъемность: \(trunkCar1.cargoCapacity), \nКузов загружен на : \(trunkCar1.cargoLoadPerCent) процентов.")
print("\ntrunkCar2 имеет следующие характеристики: \nМарка: \(trunkCar2.carBrand), \nМодель: \(trunkCar2.carModel), \nГод выпуска: \(trunkCar2.releaseYear), \nГрузоподъемность: \(trunkCar2.cargoCapacity), \nКузов загружен на : \(trunkCar2.cargoLoadPerCent) процентов.")
print("\ntrunkCar3 имеет следующие характеристики: \nМарка: \(trunkCar3.carBrand), \nМодель: \(trunkCar3.carModel), \nГод выпуска: \(trunkCar3.releaseYear), \nГрузоподъемность: \(trunkCar3.cargoCapacity), \nКузов загружен на : \(trunkCar3.cargoLoadPerCent) процентов.")

print("\nsportCar1 имеет следующие характеристики: \nМарка: \(sportCar1.carBrand), \nМодель: \(sportCar1.carModel), \nГод выпуска: \(sportCar1.releaseYear), \nМаксимальная скорость: \(sportCar1.maxSpeed) км/ч")
print("\nsportCar2 имеет следующие характеристики: \nМарка: \(sportCar2.carBrand), \nМодель: \(sportCar2.carModel), \nГод выпуска: \(sportCar2.releaseYear), \nМаксимальная скорость: \(sportCar2.maxSpeed) км/ч")
print("\nsportCar3 имеет следующие характеристики: \nМарка: \(sportCar3.carBrand), \nМодель: \(sportCar3.carModel), \nГод выпуска: \(sportCar3.releaseYear), \nМаксимальная скорость: \(sportCar3.maxSpeed) км/ч\n")
