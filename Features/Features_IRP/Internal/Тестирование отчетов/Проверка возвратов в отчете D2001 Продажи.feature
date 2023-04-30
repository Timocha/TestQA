﻿#language: ru

@tree

Функционал: тестирование отчетов

Как Тестировщик я хочу
протестировать отчеты 
чтобы проверить что у пользователя не возникло проблем с отчетом D2001  

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: _040201 подготовительный сценарий (тестирование отчетов)
	Когда экспорт основных данных
	Когда экспорт документов возвратов покупателя
	И я выполняю код встроенного языка на сервере
		| 'Документы.SalesOrder.НайтиПоНомеру(1).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'      |
		| 'Документы.SalesOrder.НайтиПоНомеру(2).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'      |
		| 'Документы.SalesOrder.НайтиПоНомеру(3).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'      |
		| 'Документы.PurchaseInvoice.НайтиПоНомеру(1).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);' |
		| 'Документы.PurchaseInvoice.НайтиПоНомеру(2).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);' |
		| 'Документы.PurchaseInvoice.НайтиПоНомеру(3).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);' |
		| 'Документы.SalesInvoice.НайтиПоНомеру(1).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'    |
		| 'Документы.SalesInvoice.НайтиПоНомеру(2).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'    |
		| 'Документы.SalesInvoice.НайтиПоНомеру(3).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'    |
		| 'Документы.SalesReturn.НайтиПоНомеру(1).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'     |
		| 'Документы.SalesReturn.НайтиПоНомеру(2).ПолучитьОбъект().Записать(РежимЗаписиДокумента.Проведение);'     |

Сценарий: _040202 проверка возвратов в отчете D2001 Продажи
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю 'Отчеты' 'D2001 Продажи'
	Когда открылось окно 'D2001 Продажи'
	И я нажимаю на кнопку с именем 'FormChangeVariant'
	Тогда открылось окно 'Вариант "Default" отчета "D2001 Продажи"'
	И я выбираю файл '$КаталогПроекта$\Files\НастройкиОтчетаD2001Возраты.xml'
	И в таблице "SettingsComposerSettings" я нажимаю на кнопку с именем 'SettingsComposerSettingsLoadSettings'
	И я нажимаю на кнопку с именем 'FormEndEdit'
	Когда открылось окно 'D2001 Продажи'
	И я нажимаю на кнопку с именем 'FormGenerate'
	И	я жду когда в табличном документе "Result" заполнится ячейка "R2C1" в течение 20 секунд
	И табличный документ "Result" содержит строки из макета "D2001 возвраты" по шаблону
	

		