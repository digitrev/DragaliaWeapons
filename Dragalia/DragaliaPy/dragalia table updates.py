import requests
import pyodbc
import getpass
import sys

#DB parameters
print("0: Development")
print("1: Staging")
print("2: Production")
env=input("Enter environment number: ")
if (env=="0"):
    DBName="DragaliaV2"
    serverName = "TREVOR2020"
    connectionString=f"Driver={{SQL Server}};Server={serverName};Database={DBName};Trusted_Connection=yes;"
else: 
    if (env=="1"):
        DBName="DragaliaStaging"
    elif (env=="2"):
        DBName="DragaliaDB"
    else:
        sys.exit("Invalid selection")
    your_password_here=getpass.getpass(f"Password for {DBName}: ")
    connectionString = f"Driver={{ODBC Driver 17 for SQL Server}};Server=tcp:dragaliadbdbserver.database.windows.net,1433;Database={DBName};Uid=TrevorB;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"

#array of useful data?
parameterDict = dict()
parameterDict["Ability"]={"tables":"Abilities","fields":"GenericName,Name,Id,AbilityGroup"}
parameterDict["AbilityGroup"]={"tables":"AbilityGroup","fields":"Id,GroupName"}
parameterDict["Adventurer"]={"tables":"Adventurers","fields":"IdLong,VariationId,FullName,Rarity,ElementalTypeId,WeaponTypeId,ManaCircleName,MaxLimitBreakCount,CharaLimitBreakId","order_by":"IdLong"}
parameterDict["Affinity"]={"tables":"AffinityBonus","fields":"Id,Name"}
parameterDict["CharaLimitBreak"]={"tables":"CharaLimitBreak","fields":"Id,OrbData1Id1,OrbData2Id1,OrbData3Id1,OrbData4Id1,OrbData5Id1,OrbData1Num1,OrbData2Num1,OrbData3Num1,OrbData4Num1,OrbData5Num1,OrbData1Id2,OrbData2Id2,OrbData3Id2,OrbData4Id2,OrbData5Id2,OrbData1Num2,OrbData2Num2,OrbData3Num2,OrbData4Num2,OrbData5Num2,OrbData1Id3,OrbData2Id3,OrbData3Id3,OrbData4Id3,OrbData5Id3,OrbData1Num3,OrbData2Num3,OrbData3Num3,OrbData4Num3,OrbData5Num3,OrbData1Id4,OrbData2Id4,OrbData3Id4,OrbData4Id4,OrbData5Id4,OrbData1Num4,OrbData2Num4,OrbData3Num4,OrbData4Num4,OrbData5Num4,OrbData1Id5,OrbData2Id5,OrbData3Id5,OrbData4Id5,OrbData5Id5,OrbData1Num5,OrbData2Num5,OrbData3Num5,OrbData4Num5,OrbData5Num5"}
parameterDict["Dragon"]={"tables":"Dragons","fields":"Id,FullName,Rarity,ElementalTypeId","where":"ReleaseDate>'2000-01-01' AND IsPlayable=1"}
parameterDict["Facility"]={"tables":"Facilities","fields":"Id,Name,Available"}
parameterDict["Material"]={"tables":"Materials","fields":"Name,Id"}
parameterDict["MCMaterials"]={"tables":"MCMaterials","fields":"Id,FireMaterialId,WaterMaterialId,WindMaterialId,LightMaterialId,DarkMaterialId"}
parameterDict["MCNodes"]={"tables":"MCNodes","fields":"MC,Id,ManaPieceType,NecessaryManaPoint","order_by":"MC,Id"}
parameterDict["ManaPieceElement"]={"tables":"ManaPieceElement","fields":"ElementId,ManaPieceType,ManaMaterialId11,ManaMaterialId12,ManaMaterialId13,ManaMaterialQuantity11,ManaMaterialQuantity12,ManaMaterialQuantity13,NeedDewPoint1,ManaMaterialId21,ManaMaterialId22,ManaMaterialId23,ManaMaterialQuantity21,ManaMaterialQuantity22,ManaMaterialQuantity23,NeedDewPoint2,ManaMaterialId31,ManaMaterialId32,ManaMaterialId33,ManaMaterialQuantity31,ManaMaterialQuantity32,ManaMaterialQuantity33,NeedDewPoint3,ManaMaterialId41,ManaMaterialId42,ManaMaterialId43,ManaMaterialQuantity41,ManaMaterialQuantity42,ManaMaterialQuantity43,NeedDewPoint4"}
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
