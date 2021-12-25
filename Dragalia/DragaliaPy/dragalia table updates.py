import requests
import pyodbc
import getpass
import sys

#DB parameters
DBName="DragaliaV2"
serverName = "TREVOR2020"
connectionString=f"Driver={{SQL Server}};Server={serverName};Database={DBName};Trusted_Connection=yes;"

#array of useful data?
parameterDict = dict()
parameterDict["Ability"]={"tables":"Abilities","fields":"GenericName,Name,Id,AbilityGroup"}
parameterDict["AbilityGroup"]={"tables":"AbilityGroup","fields":"Id,GroupName"}
parameterDict["Adventurer"]={"tables":"Adventurers","fields":"IdLong,VariationId,FullName,Rarity,ElementalTypeId,WeaponTypeId,ManaCircleName,MaxLimitBreakCount,CharaLimitBreakId,PieceMaterialElementId,UniqueGrowMaterialId1,UniqueGrowMaterialId2","order_by":"IdLong"}
parameterDict["Affinity"]={"tables":"AffinityBonus","fields":"Id,Name"}
parameterDict["Dragon"]={"tables":"Dragons","fields":"Id,FullName,Rarity,ElementalTypeId","where":"ReleaseDate>'2000-01-01' AND IsPlayable=1"}
parameterDict["Facility"]={"tables":"Facilities","fields":"Id,Name,Available"}
parameterDict["Material"]={"tables":"Materials","fields":"Name,Id"}
parameterDict["MCNodeCost"]={"tables":"MCNodeCost","fields":"MC,MCElementId,Floor,No,Material,MaterialQuantity","order_by":"MC,MCElementId,Floor,No,Material"}
parameterDict["Passive"]={"tables":"WeaponPassiveAbility","fields":"Id,WeaponPassiveAbilityNo,WeaponTypeId,ElementalTypeId,AbilityId,UnlockCoin,UnlockMaterialId1,UnlockMaterialQuantity1,UnlockMaterialId2,UnlockMaterialQuantity2,UnlockMaterialId3,UnlockMaterialQuantity3,UnlockMaterialId4,UnlockMaterialQuantity4,UnlockMaterialId5,UnlockMaterialQuantity5,SortId"}
parameterDict["Weapon"]={"tables":"Weapons","where":"Obtain LIKE '%Crafting%'","fields":"Id,Name,WeaponSeries,WeaponSeriesId,WeaponType,WeaponTypeId,Rarity,ElementalType,ElementalTypeId,CreateCoin,CreateEntity1,CreateEntityQuantity1,CreateEntity2,CreateEntityQuantity2,CreateEntity3,CreateEntityQuantity3,CreateEntity4,CreateEntityQuantity4,CreateEntity5,CreateEntityQuantity5,WeaponBodyBuildupGroupId"}
parameterDict["WeaponLevel"]={"tables":"WeaponBodyBuildupLevel","fields":"Id,RarityGroup,Level,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3"}
parameterDict["WeaponUpgrade"]={"tables":"WeaponBodyBuildupGroup","fields":"WeaponBodyBuildupGroupId,BuildupPieceTypeId,BuildupPieceType,Step,BuildupCoin,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3,BuildupMaterialId4,BuildupMaterialQuantity4,BuildupMaterialId5,BuildupMaterialQuantity5,BuildupMaterialId6,BuildupMaterialQuantity6,BuildupMaterialId7,BuildupMaterialQuantity7,BuildupMaterialId8,BuildupMaterialQuantity8,BuildupMaterialId9,BuildupMaterialQuantity9,BuildupMaterialId10,BuildupMaterialQuantity10"}
parameterDict["WeaponLimit"]={"tables":"WeaponBodyRarity","fields":"Id,MaxLimitBreakCountByLimitOver0,MaxLimitBreakCountByLimitOver1,MaxLimitBreakCountByLimitOver2,MaxLimitLevelByLimitBreak0,MaxLimitLevelByLimitBreak1,MaxLimitLevelByLimitBreak2,MaxLimitLevelByLimitBreak3,MaxLimitLevelByLimitBreak4,MaxLimitLevelByLimitBreak5,MaxLimitLevelByLimitBreak6,MaxLimitLevelByLimitBreak7,MaxLimitLevelByLimitBreak8,MaxLimitLevelByLimitBreak9"}
parameterDict["Wyrmprint"]={"tables":"Wyrmprints","fields":"Id,Name,Rarity,RarityGroup,Abilities11,Abilities12,Abilities13,Abilities21,Abilities22,Abilities23,UnionAbilityGroupId,AbilityCrestBuildupGroupId,UniqueBuildupMaterialId"}
parameterDict["WyrmprintUpgrade"]={"tables":"WyrmprintBuildupGroup","fields":"Id,AbilityCrestBuildupGroupId,BuildupPieceTypeId,Step,BuildupDewPoint,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3,UniqueBuildupMaterialCount"}
parameterDict["WyrmprintLevel"]={"tables":"WyrmprintBuildupLevel","fields":"Id,RarityGroup,Level,BuildupMaterialId1,BuildupMaterialQuantity1,BuildupMaterialId2,BuildupMaterialQuantity2,BuildupMaterialId3,BuildupMaterialQuantity3,UniqueBuildupMaterialCount"}
parameterDict["WyrmprintLimit"]={"tables":"WyrmprintRarity","fields":"Id,MaxLimitLevelByLimitBreak0,MaxLimitLevelByLimitBreak1,MaxLimitLevelByLimitBreak2,MaxLimitLevelByLimitBreak3,MaxLimitLevelByLimitBreak4"}

#Setting up request parameters
print('Setting up request parameters')
apiUrl = "https://dragalialost.wiki/api.php"

baseParams = dict()
baseParams["action"]="cargoquery"
baseParams["format"]="json"
baseParams["limit"]=100

baseCountParams = baseParams.copy()

baseParams["order_by"] = "Id"
baseParams["offset"] = 0


#setting up connection
print('Connecting to DB')
conn = pyodbc.connect(connectionString)
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
cursor.execute('EXECUTE den.spInitializeDen')
cursor.execute('EXECUTE den.spLoadCore')
cursor.commit()

#input("Press enter to finish")
