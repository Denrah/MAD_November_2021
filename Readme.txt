В приложении используется архитектура MVVM + слой сервисов. 

Реализованы следующие паттерны:
1. Singletone.
Сервисы по пути /WordsFactory/Services/DictionaryRemoteServiceSingletone.swift
И /WordsFactory/Services/DictionaryLocalServiceSingletone.swift
Данные сервисы отвечают за запросы к серверу и хранение данных

2. Proxy
Находится по пути /WordsFactory/Services/DictionaryServiceProxy.swift
Класс является посредником между вьюмоделями и описанными выше сервисами. В зависимости от задачи и наличия интернета перенаправляет на один из сервисов выше

3. Factory method
Находится по пути /WordsFactory/Common/Tab Bar/TabBarFactory.swift
Является фабричным методом, который создает объекты для таббара