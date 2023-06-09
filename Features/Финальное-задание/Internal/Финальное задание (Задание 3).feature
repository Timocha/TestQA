﻿#language: ru

@tree

Функционал: Финальное задание (Задание 3)

Как Тестировщик я хочу
протестировать документ РасходТовара 
чтобы пользователь мог вести учет отгрузок   

Переменные:
	СсылкаДокумента = '{СтрЗаменить(Строка(Новый УникальныйИдентификатор()),"-","")}'
	НавигационнаяСсылка = '{"e1cib/data/Документ.РасходТовара?ref=" + Контекст.СсылкаДокумента}'
	
	ДатаДокумента = '{Формат(НачалоДня(ТекущаяДата()),"Л=ru_RU; ДФ=dd.MM.yyyy")}'
	
	* Товары
		| 'Имя'      | 'Представление' | 'Значение'                                                          | 'ТекстВыделения'                    |
		| 'Валенки'  | 'Валенки'       | 'e1cib/data/Справочник.Товары?ref=a9b200055d49b45e11db9b1315c596e3' | '<b><colorstyle -46>Валенки</></>'  |
		| 'Доставка' | 'Доставка'      | 'e1cib/data/Справочник.Товары?ref=8d3a000d8843cd1b11dd321ba7a30aaf' | '<b><colorstyle -46>Доставка</></>' |
	* Организации		
		| 'Имя'                     | 'ВводТекста' | 'Представление'      | 'Значение'                                                               |
		| 'БезВалютыВзаиморасчетов' | '1000'       | 'ООО "1000 мелочей"' | 'e1cib/data/Справочник.Организации?ref=8d34000d8843cd1b11dd2bea12f94c65' |
		| 'СВалютойВзаиморасчетов'  | 'Все'        | 'ООО "Все для дома"' | 'e1cib/data/Справочник.Организации?ref=8d34000d8843cd1b11dd2bea12f94c63' |
	* Покупатели		
		| 'Имя'          | 'ВводТекста' | 'Значение'                                                               | 'Представление'             |
		| 'Оптовый'      | 'Мос'        | 'e1cib/data/Справочник.Контрагенты?ref=8ca0000d8843cd1b11dc8d043d710076' | 'Мосхлеб ОАО'               |
		| 'Мелкооптовый' | 'Тех'        | 'e1cib/data/Справочник.Контрагенты?ref=8ca0000d8843cd1b11dc8d043d71007a' | 'Магазин "Бытовая техника"' |
	* ВидыЦен
		| 'Имя'          | 'ВводТекста' | 'Представление' |'Значение' |
		| 'Оптовая'      | 'О'          | 'Оптовая'       |'e1cib/data/Справочник.ВидыЦен?ref=a9b000055d49b45e11db8c4c9d5c4225' |
		| 'Мелкооптовая' | 'М'          | 'Мелкооптовая'  |'e1cib/data/Справочник.ВидыЦен?ref=a9b000055d49b45e11db8c4c9d5c4226' |
	* Валюты
		| 'Имя'    | 'ВводТекста' | 'Представление' |'Значение' |
		| 'Рубль'  | 'Р'          | 'Рубли'         |'e1cib/data/Справочник.Валюты?ref=a9b000055d49b45e11db8c4421dda1c5' |
		| 'Доллар' | 'US'         | 'USD'           |'e1cib/data/Справочник.Валюты?ref=a9b000055d49b45e11db8c4c9d5c4222' |
	* Склады
		| 'Имя'     | 'ВводТекста' | 'Представление' |'Значение' |
		| 'Большой' | 'Б'          | 'Большой'       |'e1cib/data/Справочник.Склады?ref=a9b000055d49b45e11db8b8bee7616e1' |
		| 'Малый'   | 'М'          | 'Малый'         |'e1cib/data/Справочник.Склады?ref=a9b000055d49b45e11db8b8bdc1aadc2' |
Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: _0301 подготовительный (документ РасходТовара)
	Когда экспорт констант финального задания
	Когда экспорт основных данных финального задания

Сценарий: _0302 РасходТовара (создание и заполнение документа)
	И я закрываю все окна клиентского приложения
	Когда В панели разделов я выбираю 'Продажи'
	И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
	Тогда открылось окно 'Продажи товара'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Продажа товара (создание)'
	* Доступность реквизитов шапки
		И элемент формы "Дата" доступен
		И элемент формы "Номер" доступен
		И элемент формы "Организация" доступен
		И элемент формы "Покупатель" доступен
		И элемент формы "Склад" доступен
		И элемент формы "Вид цен" доступен
		И поле "Валюта взиморасчетов" не существует
	* Заполнение полей Шапки
		* Дата - начало дня
			И Я запоминаю значение выражения '$ДатаДокумента$ + "  0:00:00"' в переменную "ДатаРасхода"
			И поле "Дата" равно переменной "ДатаРасхода"
		* Номер - попытка изменения номера вызывает диалог продолжения редактирования
			И Я запоминаю в переменную "ТекстСообщения" значение "Номер заполняется при записи автоматически.  Продолжить редактирование?"
			И в поле с именем 'Номер' я ввожу текст ''
			Тогда открылась форма с именем 'MessageBox'
			И элемент формы с именем "Message" имеет значение "$ТекстСообщения$" тогда
			И я нажимаю на кнопку 'Нет'
		* Организация
			И из выпадающего списка "Организация" я выбираю по строке "Организации.БезВалютыВзаиморасчетов.ВводТекста"
			И представление элемента "Организация" стало равно "Организации.БезВалютыВзаиморасчетов.Представление"
			* Изменение организации и видимость Валюта взиморасчетов
				И из выпадающего списка "Организация" я выбираю по строке "Организации.СВалютойВзаиморасчетов.ВводТекста"
				И представление элемента "Организация" стало равно "Организации.СВалютойВзаиморасчетов.Представление"
				И элемент формы "Валюта взиморасчетов" присутствует на форме
		* Покупатель
			И из выпадающего списка "Покупатель" я выбираю по строке "Покупатели.Оптовый.ВводТекста"
			И представление элемента "Покупатель" стало равно "Покупатели.Оптовый.Представление"
			* автоматическое заполнение Вида цен
				И представление элемента "Вид цен" стало равно "ВидыЦен.Оптовая.Представление"	
			* При изменении Покупателя и Вид цены меняется соответственно
				И из выпадающего списка "Покупатель" я выбираю по строке "Покупатели.Мелкооптовый.ВводТекста"
				И представление элемента "Покупатель" стало равно "Покупатели.Мелкооптовый.Представление"
				* автоматическое заполнение Вида цен
					И представление элемента "Вид цен" стало равно "ВидыЦен.Мелкооптовая.Представление"
		* Склад	
			И из выпадающего списка "Склад" я выбираю по строке "Склады.Большой.ВводТекста"
			И представление элемента "Склад" стало равно "Склады.Большой.Представление"
		* Валюта
		 	И из выпадающего списка "Валюта взиморасчетов" я выбираю по строке "Валюты.Рубль.ВводТекста"
			И представление элемента "Валюта взиморасчетов" стало равно "Валюты.Рубль.Представление"
	* Заполнение ТЧ Товары
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		* Товар
			И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
			Тогда открылось окно 'Товары'
			* поиск товара по складу
				И в таблице "Список" в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст 'Товары.Валенки.Представление'
				И в таблице "Список" я перехожу к строке:
					| 'Наименование'                  |
					| 'Товары.Валенки.ТекстВыделения' |
				Если в таблице "Список" поле с именем "Количество" заполнено Тогда
					И в таблице 'Список' поле 'Количество' имеет значение '*,00' по шаблону
				И в таблице "Список" я выбираю текущую строку
			* автоматическое заполнение Цены, Количества и Суммы
				Тогда таблица "Товары" стала равной:
					| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'    |
					| '1' | 'Товары.Валенки.Представление' | '1 900,00' | '1,00'       | '1 900,00' |
		* Изменение склада отражается в остатках
			И из выпадающего списка "Склад" я выбираю по строке "Склады.Малый.ВводТекста"
			И представление элемента "Склад" стало равно "Склады.Малый.Представление"
			И в таблице "Товары" я выбираю текущую строку
			И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
			Тогда открылось окно 'Товары'
			И в таблице "Список" я перехожу к строке:
					| 'Наименование'                 |
					| 'Товары.Валенки.Представление' |
			Если в таблице "Список" поле с именем "Количество" заполнено Тогда
				И в таблице 'Список' поле 'Количество' имеет значение '*,00' по шаблону
			И Я закрываю окно 'Товары'
		* Изменение вида цен - пересчет цены и суммы
			И из выпадающего списка "Вид цен" я выбираю по строке "ВидыЦен.Оптовая.ВводТекста"
			И представление элемента "Вид цен" стало равно "ВидыЦен.Оптовая.Представление"
			Тогда таблица "Товары" стала равной:
					| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'    |
					| '1' | 'Товары.Валенки.Представление' | '1 800,00' | '1,00'       | '1 800,00' |
		* Изменение количество - пересчет суммы				
			И в таблице "Товары" я перехожу к строке:
				| 'Товар'   |
				| 'Валенки' |
			И в таблице "Товары" я выбираю текущую строку
			И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10,00'
			И в таблице "Товары" я завершаю редактирование строки
			Тогда таблица "Товары" стала равной:
					| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'     |
					| '1' | 'Товары.Валенки.Представление' | '1 800,00' | '10,00'      | '18 000,00' |
		* Изменение цены - пересчет суммы						
			И в таблице "Товары" я перехожу к строке:
				| 'Товар'                        |
				| 'Товары.Валенки.Представление' |
			И в таблице "Товары" я выбираю текущую строку
			И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '2000,00'
			И в таблице "Товары" я завершаю редактирование строки
			Тогда таблица "Товары" стала равной:
					| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'     |
					| '1' | 'Товары.Валенки.Представление' | '2 000,00' | '10,00'      | '20 000,00' |
	* Заполнение закладки Прочее
		И я перехожу к закладке с именем "Прочее"
		И в поле с именем 'ОбоснованиеОтгрузки' я ввожу текст 'Товары.Валенки.Представление'
	* Запись документа				
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		И я запоминаю значение поля "Номер" как "НомерДокумента"
		И Я закрываю окно 'Продажа * от *'
		Когда В панели открытых я выбираю 'Продажи товара'
		Тогда открылось окно 'Продажи товара'
		И в таблице "Список" я перехожу к строке:
			| 'Номер'            |
			| '$НомерДокумента$' |
		И в таблице "Список" я выбираю текущую строку
		Когда открылось окно 'Продажа * от *'
		Тогда элемент формы с именем "Номер" стал равен '$НомерДокумента$'
		И элемент формы с именем "Дата" стал равен шаблону '$ДатаДокумента$ *'
		И элемент формы с именем "Организация" стал равен 'Организации.СВалютойВзаиморасчетов.Представление'
		И элемент формы с именем "Склад" стал равен 'Склады.Малый.Представление'
		И элемент формы с именем "Покупатель" стал равен 'Покупатели.Мелкооптовый.Представление'
		И элемент формы с именем "ВидЦен" стал равен 'ВидыЦен.Оптовая.Представление'
		И элемент формы с именем "Валюта" стал равен 'Валюты.Рубль.Представление'
		И таблица "Товары" стала равной:
			| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'     |
			| '1' | 'Товары.Валенки.Представление' | '2 000,00' | '10,00'      | '20 000,00' |
		
		И элемент формы с именем "ТоварыИтогКоличество" стал равен '10'
		И элемент формы с именем "ТоварыИтогСумма" стал равен '20 000'
		И элемент формы с именем "ОбоснованиеОтгрузки" стал равен 'Товары.Валенки.Представление'
									
Сценарий: _0303 Расход товара (проведение документа)
	И я закрываю все окна клиентского приложения
	Когда В панели разделов я выбираю 'Продажи'
	И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
	Тогда открылось окно 'Продажи товара'		
	* Подготовка
		И поступление валенок
		И я проверяю или создаю для документа "РасходТовара" объекты с обмен данными загрузка истина:
		| 'Ссылка'                | 'ПометкаУдаления' | 'Дата'                    | 'Проведен' | 'Покупатель'                       | 'Склад'                 | 'Валюта'                | 'ВидЦен'                   | 'ОбоснованиеОтгрузки'          | 'Организация'                                 |
		| '$НавигационнаяСсылка$' | 'False'           | '$ДатаДокумента$ 0:00:00' | 'False'    | 'Покупатели.Мелкооптовый.Значение' | 'Склады.Малый.Значение' | 'Валюты.Рубль.Значение' | 'ВидыЦен.Оптовая.Значение' | 'Товары.Валенки.Представление' | 'Организации.СВалютойВзаиморасчетов.Значение' |

		И я перезаполняю для объекта табличную часть "Товары":
			| 'Ссылка'                | 'Товар'                   | 'Цена' | 'Количество' | 'Сумма' |
			| '$НавигационнаяСсылка$' | 'Товары.Валенки.Значение' | 2000   | 10           | 20000   |
		Дано Я открываю навигационную ссылку "$НавигационнаяСсылка$"
	* Проведение документа
		* Некорректные данные
			Когда открылось окно 'Продажа * от * *'
			И в таблице "Товары" я перехожу к строке
					| 'Товар'                        |
					| 'Товары.Валенки.Представление' |
			И в таблице "Товары" я выбираю текущую строку
			И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10 000,00'
			И в таблице "Товары" я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ФормаПровести'
			Тогда появилось предупреждение, содержащее текст 'Не удалось провести "Продажа *"!  Проверьте вводимые данные на корректность. Если проблему решить не удается, то звоните Петру Петрову по телефону +79999999999' по шаблону
			И я нажимаю на кнопку с именем 'OK'
			И Я запоминаю в переменную "Товар" значение 'Товары.Валенки.Представление'
			И Я запоминаю в переменную "Склад" значение 'Склады.Малый.Представление'
			И Я запоминаю в переменную "ТекстСообщения" значение "Не хватает*единиц товара*$Товар$*на складе*$Склад$*Максимальное количество:*" 
			И я удаляю переменную 'Товар'
			И я удаляю переменную 'Склад'
			Тогда в логе сообщений TestClient есть строка '$ТекстСообщения$' по шаблону	
					
		* Корректные данные
			* Ввод корректного количество
				И в таблице "Товары" я перехожу к строке
						| 'Товар' |
						| 'Товары.Валенки.Представление' |
				И в таблице "Товары" я выбираю текущую строку
				И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10,00'	
				И я завершаю редактирование строки

			Когда открылось окно 'Продажа * от *'
			Если существует переменная "НомерДокумента" Тогда
				И я удаляю переменную 'НомерДокумента'	
			И я запоминаю значение поля "Номер" как "НомерДокумента"
			И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
			И я жду закрытия окна 'Продажа * от *' в течение 20 секунд
			Тогда открылось окно 'Продажи товара'
			И в таблице "Список" я перехожу к строке:
				| 'Номер'            |
				| '$НомерДокумента$' |
			И Я открываю навигационную ссылку "$НавигационнаяСсылка$"
	* Проверка движений документа
		Когда открылось окно 'Продажа * от *'
		* Регистр взаиморасчетов с контрагентами
			И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр взаиморасчетов с контрагентами'
			Тогда таблица "Список" стала равной по шаблону:
				| 'Период'            | 'Регистратор'                                   | 'Номер строки' | 'Контрагент'                            | 'Сумма'     | 'Валюта'                     |
				| '$ДатаДокумента$ *' | 'Продажа $НомерДокумента$ от $ДатаДокумента$ *' | '1'            | 'Покупатели.Мелкооптовый.Представление' | '20 000,00' | 'Валюты.Рубль.Представление' |
		* Регистр продаж	
			И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр продаж'
			Тогда таблица "Список" стала равной по шаблону:
				| 'Период'            | 'Регистратор'                                   | 'Номер строки' | 'Покупатель'                            | 'Товар'                        | 'Количество' | 'Сумма'     |
				| '$ДатаДокумента$ *' | 'Продажа $НомерДокумента$ от $ДатаДокумента$ *' | '1'            | 'Покупатели.Мелкооптовый.Представление' | 'Товары.Валенки.Представление' | '10,00'      | '20 000,00' |
		* Регистр товарных запасов 	
			И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр товарных запасов'
			Тогда таблица "Список" стала равной по шаблону:
				| 'Период'            | 'Регистратор'                                   | 'Номер строки' | 'Товар'                        | 'Склад'                      | 'Количество' |
				| '$ДатаДокумента$ *' | 'Продажа $НомерДокумента$ от $ДатаДокумента$ *' | '1'            | 'Товары.Валенки.Представление' | 'Склады.Малый.Представление' | '10,00'      |
Сценарий: _0304 РасходТовара (печатные формы и кнопки)
	И я закрываю все окна клиентского приложения
	Когда В панели разделов я выбираю 'Продажи'
	И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
	Тогда открылось окно 'Продажи товара'		
	* Подготовка
		И поступление валенок
		И я проверяю или создаю для документа "РасходТовара" объекты с обмен данными загрузка истина:
		| 'Ссылка'                | 'ПометкаУдаления' | 'Дата'                    | 'Проведен' | 'Покупатель'                       | 'Склад'                 | 'Валюта'                | 'ВидЦен'                   | 'ОбоснованиеОтгрузки'          | 'Организация'                                 |
		| '$НавигационнаяСсылка$' | 'False'           | '$ДатаДокумента$ 0:00:00' | 'False'    | 'Покупатели.Мелкооптовый.Значение' | 'Склады.Малый.Значение' | 'Валюты.Рубль.Значение' | 'ВидыЦен.Оптовая.Значение' | 'Товары.Валенки.Представление' | 'Организации.СВалютойВзаиморасчетов.Значение' |

		И я перезаполняю для объекта табличную часть "Товары":
			| 'Ссылка'                | 'Товар'                   | 'Цена' | 'Количество' | 'Сумма' |
			| '$НавигационнаяСсылка$' | 'Товары.Валенки.Значение' | 2000   | 10           | 20000   |
		
		Дано Я открываю навигационную ссылку "$НавигационнаяСсылка$"
		Если существует переменная "НомерДокумента" Тогда
			И я удаляю переменную 'НомерДокумента'	
		И я запоминаю значение поля "Номер" как "НомерДокумента"
		* Проверяю документ
			Тогда элемент формы с именем "Номер" стал равен '$НомерДокумента$'
			И элемент формы с именем "Дата" стал равен шаблону '$ДатаДокумента$ *'
			И элемент формы с именем "Организация" стал равен 'Организации.СВалютойВзаиморасчетов.Представление'
			И элемент формы с именем "Склад" стал равен 'Склады.Малый.Представление'
			И элемент формы с именем "Покупатель" стал равен 'Покупатели.Мелкооптовый.Представление'
			И элемент формы с именем "ВидЦен" стал равен 'ВидыЦен.Оптовая.Представление'
			И элемент формы с именем "Валюта" стал равен 'Валюты.Рубль.Представление'
			И таблица "Товары" стала равной:
				| 'N' | 'Товар'                        | 'Цена'     | 'Количество' | 'Сумма'     |
				| '1' | 'Товары.Валенки.Представление' | '2 000,00' | '10,00'      | '20 000,00' |
			
			И элемент формы с именем "ТоварыИтогКоличество" стал равен '10'
			И элемент формы с именем "ТоварыИтогСумма" стал равен '20 000'
			И элемент формы с именем "ОбоснованиеОтгрузки" стал равен 'Товары.Валенки.Представление'
				
	* Добавление услуги Доставки
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Товары.Доставка.Представление'
		* Поле количество для товара с видом Услуга не доступно для редактирования
			Когда Проверяю шаги на Исключение:
					|'И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст "15,00"'|
		И в таблице "Товары" я завершаю редактирование строки
		И я завершаю редактирование строки
		* Поле количество у услуги не заполнено
			Тогда таблица "Товары" стала равной:
				| 'N' | 'Товар'                         | 'Цена'     | 'Количество' | 'Сумма'     |
				| '1' | 'Товары.Валенки.Представление'  | '2 000,00' | '10,00'      | '20 000,00' |
				| '2' | 'Товары.Доставка.Представление' | '200,00'   | ''           | '200,00'    |
		И элемент формы с именем "ТоварыИтогКоличество" стал равен '11'
		И элемент формы с именем "ТоварыИтогСумма" стал равен '20 200'
	* Кнопка Пересчитать	
		И я нажимаю на кнопку с именем 'Пересчитать'
		* Поле Количество у Услуги заполнено
		Тогда таблица "Товары" стала равной:
				| 'N' | 'Товар'                         | 'Цена'     | 'Количество' | 'Сумма'     |
				| '1' | 'Товары.Валенки.Представление'  | '2 000,00' | '10,00'      | '20 000,00' |
				| '2' | 'Товары.Доставка.Представление' | '200,00'   | '1,00'       | '200,00'    |
	* Печать Расходной накладной
		* Невозможно распечатать для не проведенного документа
			Когда открылось окно 'Продажа * от * *'
			И я нажимаю на кнопку с именем 'ФормаДокументРасходТовараПечатьРасходнойНакладной'
			
			Если существует переменная "ТекстСообщения" Тогда
				И я удаляю переменную 'ТекстСообщения'
			И Я запоминаю в переменную "ТекстСообщения" значение "Документ не проведен: Продажа $НомерДокумента$*"	
			Тогда в логе сообщений TestClient есть строка '$ТекстСообщения$' по шаблону	 
		* Печать для проведенного документа
			И я нажимаю на кнопку с именем 'ФормаПровести'
			Тогда открылось окно 'Продажа * от *'
			И я нажимаю на кнопку с именем 'ФормаДокументРасходТовараПечатьРасходнойНакладной'
			Тогда открылось окно 'Таблица'
			И табличный документ "SpreadsheetDocument" равен по шаблону:
				| 'Расход товара'                 | ''                                             | ''           | ''       |
				| ''                              | ''                                             | ''           | ''       |
				| 'Номер'                         | '$НомерДокумента$'                             | ''           | ''       |
				| 'Дата'                          | '$ДатаДокумента$ *'                            | ''           | ''       |
				| 'Покупатель'                    | 'Покупатели.Мелкооптовый.Представление'        | ''           | ''       |
				| 'Склад'                         | 'Склады.Малый.Представление'                   | ''           | ''       |
				| 'Сумма'                         | '20 200 рублей (Двадцать тысяч двести рублей)' | ''           | ''       |
				| 'Вес'                           | ''                                             | ''           | ''       |
				| ''                              | ''                                             | ''           | ''       |
				| 'Товар'                         | 'Цена'                                         | 'Количество' | 'Сумма'  |
				| 'Товары.Валенки.Представление'  | '2 000'                                        | '10'         | '20 000' |
				| 'Товары.Доставка.Представление' | '200'                                          | '1'          | '200'    |
			
							
								
						
					
