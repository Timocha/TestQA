﻿#language: ru

@tree

Функционал: Создание Заказа

Как Менеджер я хочу
создать Заказ 
чтобы планировать отгрузки   

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Переменные:
	* Товары
		| 'Имя'     | 'Товар'         | 'Цена'       | 'Количество'  |
		| 'Строка1' | 'Торт '         | '10,00'      | 10            |
		| 'Строка2' | 'Veko345MO'     | '100,00'     | 1             |
		| 'Строка3' | 'Доставка'      | '10,00'      | 2             |
	КоличествоИтого = '12'

Сценарий: Подготовка данных
	И перезаполнению константы для создания Заказа
	И перезаполнению организации для создания Заказа
	И загружаю данные для создания Заказа

Сценарий: Проверка Количества Итог Заказа
* Создаю новый документ
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю 'Продажи' 'Заказы'
	Тогда открылось окно 'Заказы товаров'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Когда открылось окно 'Заказ (создание)'
* Заполняю шапку Заказа
	И заполняю шапку документа Заказ
* Заполняю табличную часть Заказа
	* Добавляю строку
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'          |
			| 'Товары.Строка1.Товар'  |
		И в таблице "Список" я выбираю текущую строку
		И в таблице "Товары" я завершаю редактирование строки
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст 'Товары.Строка1.Цена'
		И в таблице "Товары" я завершаю редактирование строки
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст 'Товары.Строка1.Количество'
		И в таблице "Товары" я завершаю редактирование строки
	* Добавляю строку
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'          |
			| 'Товары.Строка2.Товар'  |
		И в таблице "Список" я выбираю текущую строку
		И в таблице "Товары" я завершаю редактирование строки
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст 'Товары.Строка2.Цена'
		И в таблице "Товары" я завершаю редактирование строки
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст 'Товары.Строка2.Количество'
		И в таблице "Товары" я завершаю редактирование строки
	* Добавляю строку
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'          |
			| 'Товары.Строка3.Товар'  |
		И в таблице "Список" я выбираю текущую строку
		И в таблице "Товары" я завершаю редактирование строки
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст 'Товары.Строка3.Цена'
		И в таблице "Товары" я завершаю редактирование строки
		И Проверяю шаги на Исключение:
				|'И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст 'Товары.Строка3.Количество''|
* Проверяю количество итого	
	Тогда элемент формы с именем "ТоварыИтогКоличество" стал равен 'КоличествоИтого'
* Записываю документ
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	И я запоминаю значение поля "Номер" как "Номер"
	И я закрываю текущее окно
* Нахожу и открываю созданный документ
	И В командном интерфейсе я выбираю 'Продажи' 'Заказы'
	Тогда открылось окно 'Заказы товаров'
	И в таблице "Список" я перехожу к строке
		| 'Номер'     |
		| '$Номер$'   |
	И в таблице "Список" я активизирую поле с именем "Номер"	
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно "Заказ * от *"
* Проверяю количество итого	
	Тогда элемент формы с именем "ТоварыИтогКоличество" стал равен 'КоличествоИтого'	
		 	
		
		
		


