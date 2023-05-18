﻿#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: экспорт РасходТовара финального задания

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: экспорт РасходТовара финального задания
	* Создать или перезаписать документы
		И для каждой строки макета "РасходТовара" я выполняю
			И я проверяю или создаю для документа "РасходТовара" объекты с обмен данными загрузка истина:
				| 'Ссылка'   | 'ПометкаУдаления'   | 'Номер'   | 'Дата'   | 'Проведен'   | 'Покупатель'   | 'Склад'   | 'Валюта'   | 'ВидЦен'   | 'ОбоснованиеОтгрузки'   | 'Организация'   |
				| '$Ссылка$' | '$ПометкаУдаления$' | '$Номер$' | '$Дата$' | '$Проведен$' | '$Покупатель$' | '$Склад$' | '$Валюта$' | '$ВидЦен$' | '$ОбоснованиеОтгрузки$' | '$Организация$' |	
	* Перезаписать ТЧ Товары
		И для каждой строки макета "РасходТовараТЧТовары" я выполняю
			И я перезаполняю для объекта табличную часть "Товары":
				| 'Ссылка'   | 'Товар'   | 'Цена'   | 'Количество'   | 'Сумма'   |
				| '$Ссылка$' | '$Товар$' | '$Цена$' | '$Количество$' | '$Сумма$' |
	* Провести или перепровести документы
		И для каждой строки макета "РасходТовара" я выполняю
			Если переменная "Проведен" имеет значение "True" Тогда	
				И я выполняю код встроенного языка на сервере
					| 'Документы.РасходТовара.НайтиПоНомеру("$Номер$").ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);' |     

	
		