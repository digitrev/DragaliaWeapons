import requests
import pyodbc

#DB parameters
serverName = "TREVOR2020"
dbName = "DragaliaV2"

#array of useful data?
parameterDict = dict()
parameterDict["Ability"]={"tables":"Abilities","fields":"GenericName,Name,Id"}
parameterDict["Material"]={"tables":"Materials","fields":"Name,Id"}
parameterDict["Passive"]={"tables":"WeaponPassiveAbility","fields":"Id,WeaponPassiveAbilityNo,WeaponTypeId,ElementalTypeId,AbilityId,UnlockCoin,UnlockMaterialId1,UnlockMaterialQuantity1,UnlockMaterialId2,UnlockMaterialQuantity2,UnlockMaterialId3,UnlockMaterialQuantity3,UnlockMaterialId4,UnlockMaterialQuantity4,UnlockMaterialId5,UnlockMaterialQuantity5,SortId"}
parameterDict["Weapon"]={"tables":"Weapons","where":"Obtain='Crafting'","fields":"Id,Name,WeaponSeries,WeaponSeriesId,WeaponType,WeaponTypeId,Rarity,ElementalType,ElementalTypeId,CreateCoin,CreateEntity1,CreateEntityQuantity1,CreateEntity2,CreateEntityQuantity2,CreateEntity3,CreateEntityQuantity3,CreateEntity4,CreateEntityQuantity4,CreateEntity5,CreateEntityQuantity5,WeaponBodyBuildupGroupId"}
parameterDict["WeaponLevel"]={"tables":"WeaponBodyBuildupLevel","fields":"Id,RarityGroup,Level,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3"}
parameterDict["WeaponUpgrade"]={"tables":"WeaponBodyBuildupGroup","fields":"WeaponBodyBuildupGroupId,BuildupPieceTypeId,BuildupPieceType,Step,BuildupCoin,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3,BuildupMaterialId4,BuildupMaterialQuantity4,BuildupMaterialId5,BuildupMaterialQuantity5,BuildupMaterialId6,BuildupMaterialQuantity6,BuildupMaterialId7,BuildupMaterialQuantity7,BuildupMaterialId8,BuildupMaterialQuantity8,BuildupMaterialId9,BuildupMaterialQuantity9,BuildupMaterialId10,BuildupMaterialQuantity10"}
parameterDict["Facility"]={"tables":"Facilities","fields":"Id,Name,Available"}

#Setting up request parameters
print('Setting up request parameters')
apiUrl = "https://dragalialost.gamepedia.com/api.php"

baseParams = dict()
baseParams["action"]="cargoquery"
baseParams["format"]="json"
baseParams["limit"]=100

baseCountParams = baseParams.copy()

baseParams["order_by"] = "Id"
baseParams["offset"] = 0


#setting up connection
print('Connecting to DB')
conn = pyodbc.connect(f"Driver={{SQL Server}};Server={serverName};Database={dbName};Trusted_Connection=yes;")
cursor = conn.cursor()

#clear out json tables
print('Truncating json tables')
cursor.execute('TRUNCATE TABLE jsn.TableJson')
cursor.commit()

#get counts from api
for table,params in parameterDict.items():
    countParams = baseCountParams.copy()
    countParams.update(params)
    countParams["fields"] = "COUNT(*) = cnt"
    countRequest = requests.get(apiUrl, params=countParams)
    count = int(countRequest.json()['cargoquery'][0]['title']['cnt'])   

    tableParams = baseParams.copy()
    tableParams.update(params)
    print(f'Getting {table} data')
    while (tableParams["offset"] < count):
        tableRequest = requests.get(apiUrl, params=tableParams)
        cursor.execute('''
            INSERT jsn.TableJson(JsonText, TableName)
            VALUES (?, ?)
        ''', tableRequest.text, table)
        cursor.commit()
        tableParams["offset"] += tableParams["limit"]

print('Loading data tables from json tables')
cursor.execute('EXECUTE jsn.spLoadCore')
print('Loading data tables from denomralized tables')
cursor.execute('EXECUTE den.spLoadCore')
cursor.commit()

#input("Press enter to finish")
