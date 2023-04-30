#language: ru
@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: экспорт констант

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Перезаполнение константы SaasMode значением

	И я перезаполняю константу "SaasMode" значением "False"

Сценарий: Перезаполнение константы EnableLinkedRowsIntegrity значением

	И я перезаполняю константу "EnableLinkedRowsIntegrity" значением "False"

Сценарий: Перезаполнение константы UseLockDataModification значением

	И я перезаполняю константу "UseLockDataModification" значением "True"

Сценарий: Перезаполнение константы UseItemKey значением

	И я перезаполняю константу "UseItemKey" значением "True"

Сценарий: Перезаполнение константы UseCompanies значением

	И я перезаполняю константу "UseCompanies" значением "True"

Сценарий: Перезаполнение константы NotFirstStart значением

	И я перезаполняю константу "NotFirstStart" значением "False"

Сценарий: Перезаполнение константы DefaultPictureStorageVolume значением

	И я перезаполняю константу "DefaultPictureStorageVolume" значением "e1cib/data/Catalog.FileStorageVolumes?ref=b772dbcd8801bc7611ec420177a49496"

