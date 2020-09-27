import requests
import pyodbc

#DB parameters
serverName = "TREVOR2020"
dbName = "DragaliaV2"

#Setting up request parameters
print('Setting up request parameters')
apiUrl = "https://dragalialost.gamepedia.com/api.php"

baseParams = dict()
baseParams["action"]="cargoquery"
baseParams["format"]="json"
baseParams["limit"]=100

abilityCountParams = baseParams.copy()
materialCountParams = baseParams.copy()
passiveCountParams = baseParams.copy()
weaponCountParams = baseParams.copy()
weaponLevelCountParams = baseParams.copy()
weaponUpgradeCountParams = baseParams.copy()

baseParams["order_by"] = "Id"
baseParams["offset"] = 0

abilityCountParams["tables"] = "Abilities"
abilityCountParams["fields"] = "COUNT(*) = cnt"

materialCountParams["tables"] = "Materials"
materialCountParams["fields"] = "COUNT(*) = cnt"

passiveCountParams["tables"] = "WeaponPassiveAbility"
passiveCountParams["fields"] = "COUNT(*) = cnt"

weaponCountParams["tables"] = "Weapons"
weaponCountParams["fields"] = "COUNT(*) = cnt"
weaponCountParams["where"] = "Obtain='Crafting'"

weaponLevelCountParams["tables"] = "WeaponBodyBuildupLevel"
weaponLevelCountParams["fields"] = "COUNT(*) = cnt"

weaponUpgradeCountParams["tables"] = "WeaponBodyBuildupGroup"
weaponUpgradeCountParams["fields"] = "COUNT(*) = cnt"

abilityParams = baseParams.copy()
abilityParams["tables"] = "Abilities"
abilityParams["fields"] = "GenericName,Name,Id"

materialParams = baseParams.copy()
materialParams["tables"] = "Materials"
materialParams["fields"] = "Name,Id"

passiveParams = baseParams.copy()
passiveParams["tables"] = "WeaponPassiveAbility"
passiveParams["fields"] = "Id,WeaponPassiveAbilityNo,WeaponTypeId,ElementalTypeId,AbilityId,UnlockCoin,UnlockMaterialId1,UnlockMaterialQuantity1,UnlockMaterialId2,UnlockMaterialQuantity2,UnlockMaterialId3,UnlockMaterialQuantity3,UnlockMaterialId4,UnlockMaterialQuantity4,UnlockMaterialId5,UnlockMaterialQuantity5"

weaponParams = baseParams.copy()
weaponParams["tables"] = "Weapons"
weaponParams["fields"] = "Id,Name,WeaponSeries,WeaponSeriesId,WeaponType,WeaponTypeId,Rarity,ElementalType,ElementalTypeId,CreateCoin,CreateEntity1,CreateEntityQuantity1,CreateEntity2,CreateEntityQuantity2,CreateEntity3,CreateEntityQuantity3,CreateEntity4,CreateEntityQuantity4,CreateEntity5,CreateEntityQuantity5,WeaponBodyBuildupGroupId"
weaponParams["where"] = "Obtain='Crafting'"

weaponLevelParams = baseParams.copy()
weaponLevelParams["tables"] = "WeaponBodyBuildupLevel"
weaponLevelParams["fields"] = "Id,RarityGroup,Level,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3"

weaponUpgradeParams = baseParams.copy()
weaponUpgradeParams["tables"] = "WeaponBodyBuildupGroup"
weaponUpgradeParams["fields"] = "WeaponBodyBuildupGroupId,BuildupPieceTypeId,BuildupPieceType,Step,BuildupCoin,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3,BuildupMaterialId4,BuildupMaterialQuantity4,BuildupMaterialId5,BuildupMaterialQuantity5,BuildupMaterialId6,BuildupMaterialQuantity6,BuildupMaterialId7,BuildupMaterialQuantity7,BuildupMaterialId8,BuildupMaterialQuantity8,BuildupMaterialId9,BuildupMaterialQuantity9,BuildupMaterialId10,BuildupMaterialQuantity10"

#setting up connection
print('Connecting to DB')
conn = pyodbc.connect(f"Driver={{SQL Server}};Server={serverName};Database={dbName};Trusted_Connection=yes;")
cursor = conn.cursor()

#get counts from api
print('Getting table counts')
abilityCountRequest = requests.get(apiUrl, params=abilityCountParams)
abilityCount = int(abilityCountRequest.json()['cargoquery'][0]['title']['cnt'])
materialCountRequest = requests.get(apiUrl, params=materialCountParams)
materialCount = int(materialCountRequest.json()['cargoquery'][0]['title']['cnt'])
passiveCountRequest = requests.get(apiUrl, params=passiveCountParams)
passiveCount = int(passiveCountRequest.json()['cargoquery'][0]['title']['cnt'])
weaponCountRequest = requests.get(apiUrl, params=weaponCountParams)
weaponCount = int(weaponCountRequest.json()['cargoquery'][0]['title']['cnt'])
weaponLevelCountRequest = requests.get(apiUrl, params=weaponLevelCountParams)
weaponLevelCount = int(weaponLevelCountRequest.json()['cargoquery'][0]['title']['cnt'])
weaponUpgradeCountRequest = requests.get(apiUrl, params=weaponUpgradeCountParams)
weaponUpgradeCount = int(weaponUpgradeCountRequest.json()['cargoquery'][0]['title']['cnt'])

#clear out json tables
print('Truncating json tables')
cursor.execute('TRUNCATE TABLE jsn.Ability')
cursor.execute('TRUNCATE TABLE jsn.Material')
cursor.execute('TRUNCATE TABLE jsn.Passive')
cursor.execute('TRUNCATE TABLE jsn.Weapon')
cursor.execute('TRUNCATE TABLE jsn.WeaponLevel')
cursor.execute('TRUNCATE TABLE jsn.WeaponUpgrade')
cursor.commit()

#get and store responses
print('Getting ability data')
while (abilityParams["offset"] < abilityCount):
    abilities = requests.get(apiUrl, params=abilityParams)
    cursor.execute('''
        INSERT jsn.Ability(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    abilityParams["offset"] += abilityParams["limit"]

print('Getting material data')
while (materialParams["offset"] < materialCount):
    abilities = requests.get(apiUrl, params=materialParams)
    cursor.execute('''
        INSERT jsn.Material(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    materialParams["offset"] += materialParams["limit"]

print('Getting passive data')
while (passiveParams["offset"] < passiveCount):
    abilities = requests.get(apiUrl, params=passiveParams)
    cursor.execute('''
        INSERT jsn.Passive(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    passiveParams["offset"] += passiveParams["limit"]

print('Getting weapon data')
while (weaponParams["offset"] < weaponCount):
    abilities = requests.get(apiUrl, params=weaponParams)
    cursor.execute('''
        INSERT jsn.Weapon(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    weaponParams["offset"] += weaponParams["limit"]

print('Getting weapon level data')
while (weaponLevelParams["offset"] < weaponLevelCount):
    abilities = requests.get(apiUrl, params=weaponLevelParams)
    cursor.execute('''
        INSERT jsn.WeaponLevel(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    weaponLevelParams["offset"] += weaponLevelParams["limit"]

print('Getting weapon upgrade data')
while (weaponUpgradeParams["offset"] < weaponUpgradeCount):
    abilities = requests.get(apiUrl, params=weaponUpgradeParams)
    cursor.execute('''
        INSERT jsn.WeaponUpgrade(JsonText)
        VALUES (?)
        ''', abilities.text)
    cursor.commit()
    weaponUpgradeParams["offset"] += weaponUpgradeParams["limit"]

print('Loading data tables from json tables')
cursor.execute('EXECUTE spLoadTablesFromJson')
cursor.commit()

#input("Press enter to finish")
