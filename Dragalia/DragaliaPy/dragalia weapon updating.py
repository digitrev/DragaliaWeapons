import requests
import pyodbc

#Setting up request parameters
print('Setting up request parameters')
apiUrl = "https://dragalialost.gamepedia.com/api.php"

baseParams = dict()
baseParams["action"]="cargoquery"
baseParams["format"]="json"
baseParams["limit"]=100
weaponCountParams = baseParams.copy()
abilityCountParams = baseParams.copy()
baseParams["order_by"] = "Id"
baseParams["offset"] = 0

abilityCountParams["tables"] = "Abilities"
abilityCountParams["fields"] = "COUNT(*) = cnt"

abilityParams = baseParams.copy()
abilityParams["tables"] = "Abilities"
abilityParams["fields"] = "GenericName,Name,Id"

weaponCountParams["tables"] = "Weapons"
weaponCountParams["fields"] = "COUNT(*) = cnt"
weaponCountParams["where"] = "Obtain='Crafting'"

weaponParams = baseParams.copy()
weaponParams["tables"] = "Weapons"
weaponParams["fields"] = "Id,MainWeaponId,WeaponName,Type,Rarity,ElementalType,Availability,Abilities11,Abilities21,AssembleCoin,CraftMaterial1,CraftMaterialQuantity1,CraftMaterial2,CraftMaterialQuantity2,CraftMaterial3,CraftMaterialQuantity3,CraftMaterial4,CraftMaterialQuantity4,CraftMaterial5,CraftMaterialQuantity5"
weaponParams["where"] = "Obtain='Crafting'"

#setting up connection
print('Connecting to DB')
conn = pyodbc.connect("Driver={SQL Server};Server=TREVOR2020;Database=Dragalia;Trusted_Connection=yes;")
cursor = conn.cursor()

#get counts from api
print('Getting weapon & ability counts')
abilityCountRequest = requests.get(apiUrl, params=abilityCountParams)
abilityCount = int(abilityCountRequest.json()['cargoquery'][0]['title']['cnt'])
weaponCountRequest = requests.get(apiUrl, params=weaponCountParams)
weaponCount = int(weaponCountRequest.json()['cargoquery'][0]['title']['cnt'])

#clear out json tables
print('Truncating json tables')
cursor.execute('TRUNCATE TABLE jsn.Ability')
cursor.execute('TRUNCATE TABLE jsn.Weapon')
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

print('Getting weapon data')
while (weaponParams["offset"] < weaponCount):
    weapons = requests.get(apiUrl, params=weaponParams)
    cursor.execute('''
        INSERT jsn.Weapon(JsonText)
        VALUES (?)
        ''', weapons.text)
    cursor.commit()
    weaponParams["offset"] += weaponParams["limit"]

print('Loading data tables from json tables')
cursor.execute('EXECUTE spLoadTablesFromJson')
cursor.commit()

input("Press enter to finish")
