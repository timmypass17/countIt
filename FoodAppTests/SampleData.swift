//
//  SampleData.swift
//  FoodAppTests
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

let surveyFoodJSON =
"""
    {
        "foodClass": "Survey",
        "description": "Banana, baked",
        "foodNutrients": [
            {
                "type": "FoodNutrient",
                "id": 34385824,
                "nutrient": {
                    "id": 1003,
                    "number": "203",
                    "name": "Protein",
                    "rank": 600,
                    "unitName": "g"
                },
                "amount": 0.820
            },
            {
                "type": "FoodNutrient",
                "id": 34385825,
                "nutrient": {
                    "id": 1004,
                    "number": "204",
                    "name": "Total lipid (fat)",
                    "rank": 800,
                    "unitName": "g"
                },
                "amount": 3.21
            },
            {
                "type": "FoodNutrient",
                "id": 34385826,
                "nutrient": {
                    "id": 1005,
                    "number": "205",
                    "name": "Carbohydrate, by difference",
                    "rank": 1110,
                    "unitName": "g"
                },
                "amount": 32.4
            },
            {
                "type": "FoodNutrient",
                "id": 34385827,
                "nutrient": {
                    "id": 1008,
                    "number": "208",
                    "name": "Energy",
                    "rank": 300,
                    "unitName": "kcal"
                },
                "amount": 161
            },
            {
                "type": "FoodNutrient",
                "id": 34385828,
                "nutrient": {
                    "id": 1018,
                    "number": "221",
                    "name": "Alcohol, ethyl",
                    "rank": 18200,
                    "unitName": "g"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385829,
                "nutrient": {
                    "id": 1051,
                    "number": "255",
                    "name": "Water",
                    "rank": 100,
                    "unitName": "g"
                },
                "amount": 62.8
            },
            {
                "type": "FoodNutrient",
                "id": 34385830,
                "nutrient": {
                    "id": 1057,
                    "number": "262",
                    "name": "Caffeine",
                    "rank": 18300,
                    "unitName": "mg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385831,
                "nutrient": {
                    "id": 1058,
                    "number": "263",
                    "name": "Theobromine",
                    "rank": 18400,
                    "unitName": "mg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385832,
                "nutrient": {
                    "id": 2000,
                    "number": "269",
                    "name": "Total Sugars",
                    "rank": 1510,
                    "unitName": "g"
                },
                "amount": 24.7
            },
            {
                "type": "FoodNutrient",
                "id": 34385833,
                "nutrient": {
                    "id": 1079,
                    "number": "291",
                    "name": "Fiber, total dietary",
                    "rank": 1200,
                    "unitName": "g"
                },
                "amount": 1.80
            },
            {
                "type": "FoodNutrient",
                "id": 34385834,
                "nutrient": {
                    "id": 1087,
                    "number": "301",
                    "name": "Calcium, Ca",
                    "rank": 5300,
                    "unitName": "mg"
                },
                "amount": 13.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385835,
                "nutrient": {
                    "id": 1089,
                    "number": "303",
                    "name": "Iron, Fe",
                    "rank": 5400,
                    "unitName": "mg"
                },
                "amount": 0.060
            },
            {
                "type": "FoodNutrient",
                "id": 34385836,
                "nutrient": {
                    "id": 1090,
                    "number": "304",
                    "name": "Magnesium, Mg",
                    "rank": 5500,
                    "unitName": "mg"
                },
                "amount": 30.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385837,
                "nutrient": {
                    "id": 1091,
                    "number": "305",
                    "name": "Phosphorus, P",
                    "rank": 5600,
                    "unitName": "mg"
                },
                "amount": 24.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385838,
                "nutrient": {
                    "id": 1092,
                    "number": "306",
                    "name": "Potassium, K",
                    "rank": 5700,
                    "unitName": "mg"
                },
                "amount": 322
            },
            {
                "type": "FoodNutrient",
                "id": 34385839,
                "nutrient": {
                    "id": 1093,
                    "number": "307",
                    "name": "Sodium, Na",
                    "rank": 5800,
                    "unitName": "mg"
                },
                "amount": 3.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385840,
                "nutrient": {
                    "id": 1095,
                    "number": "309",
                    "name": "Zinc, Zn",
                    "rank": 5900,
                    "unitName": "mg"
                },
                "amount": 0.170
            },
            {
                "type": "FoodNutrient",
                "id": 34385841,
                "nutrient": {
                    "id": 1098,
                    "number": "312",
                    "name": "Copper, Cu",
                    "rank": 6000,
                    "unitName": "mg"
                },
                "amount": 0.100
            },
            {
                "type": "FoodNutrient",
                "id": 34385842,
                "nutrient": {
                    "id": 1103,
                    "number": "317",
                    "name": "Selenium, Se",
                    "rank": 6200,
                    "unitName": "µg"
                },
                "amount": 0.100
            },
            {
                "type": "FoodNutrient",
                "id": 34385843,
                "nutrient": {
                    "id": 1105,
                    "number": "319",
                    "name": "Retinol",
                    "rank": 7430,
                    "unitName": "µg"
                },
                "amount": 26.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385844,
                "nutrient": {
                    "id": 1106,
                    "number": "320",
                    "name": "Vitamin A, RAE",
                    "rank": 7420,
                    "unitName": "µg"
                },
                "amount": 28.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385845,
                "nutrient": {
                    "id": 1107,
                    "number": "321",
                    "name": "Carotene, beta",
                    "rank": 7440,
                    "unitName": "µg"
                },
                "amount": 13.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385846,
                "nutrient": {
                    "id": 1108,
                    "number": "322",
                    "name": "Carotene, alpha",
                    "rank": 7450,
                    "unitName": "µg"
                },
                "amount": 6.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385847,
                "nutrient": {
                    "id": 1109,
                    "number": "323",
                    "name": "Vitamin E (alpha-tocopherol)",
                    "rank": 7905,
                    "unitName": "mg"
                },
                "amount": 0.110
            },
            {
                "type": "FoodNutrient",
                "id": 34385848,
                "nutrient": {
                    "id": 1114,
                    "number": "328",
                    "name": "Vitamin D (D2 + D3)",
                    "rank": 8700,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385849,
                "nutrient": {
                    "id": 1120,
                    "number": "334",
                    "name": "Cryptoxanthin, beta",
                    "rank": 7460,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385850,
                "nutrient": {
                    "id": 1122,
                    "number": "337",
                    "name": "Lycopene",
                    "rank": 7530,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385851,
                "nutrient": {
                    "id": 1123,
                    "number": "338",
                    "name": "Lutein + zeaxanthin",
                    "rank": 7560,
                    "unitName": "µg"
                },
                "amount": 20.0
            },
            {
                "type": "FoodNutrient",
                "id": 34385852,
                "nutrient": {
                    "id": 1162,
                    "number": "401",
                    "name": "Vitamin C, total ascorbic acid",
                    "rank": 6300,
                    "unitName": "mg"
                },
                "amount": 10.4
            },
            {
                "type": "FoodNutrient",
                "id": 34385853,
                "nutrient": {
                    "id": 1165,
                    "number": "404",
                    "name": "Thiamin",
                    "rank": 6400,
                    "unitName": "mg"
                },
                "amount": 0.048
            },
            {
                "type": "FoodNutrient",
                "id": 34385854,
                "nutrient": {
                    "id": 1166,
                    "number": "405",
                    "name": "Riboflavin",
                    "rank": 6500,
                    "unitName": "mg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385855,
                "nutrient": {
                    "id": 1167,
                    "number": "406",
                    "name": "Niacin",
                    "rank": 6600,
                    "unitName": "mg"
                },
                "amount": 0.640
            },
            {
                "type": "FoodNutrient",
                "id": 34385856,
                "nutrient": {
                    "id": 1175,
                    "number": "415",
                    "name": "Vitamin B-6",
                    "rank": 6800,
                    "unitName": "mg"
                },
                "amount": 0.214
            },
            {
                "type": "FoodNutrient",
                "id": 34385857,
                "nutrient": {
                    "id": 1177,
                    "number": "417",
                    "name": "Folate, total",
                    "rank": 6900,
                    "unitName": "µg"
                },
                "amount": 9.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385858,
                "nutrient": {
                    "id": 1178,
                    "number": "418",
                    "name": "Vitamin B-12",
                    "rank": 7300,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385859,
                "nutrient": {
                    "id": 1180,
                    "number": "421",
                    "name": "Choline, total",
                    "rank": 7220,
                    "unitName": "mg"
                },
                "amount": 11.2
            },
            {
                "type": "FoodNutrient",
                "id": 34385860,
                "nutrient": {
                    "id": 1185,
                    "number": "430",
                    "name": "Vitamin K (phylloquinone)",
                    "rank": 8800,
                    "unitName": "µg"
                },
                "amount": 0.400
            },
            {
                "type": "FoodNutrient",
                "id": 34385861,
                "nutrient": {
                    "id": 1186,
                    "number": "431",
                    "name": "Folic acid",
                    "rank": 7000,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385862,
                "nutrient": {
                    "id": 1187,
                    "number": "432",
                    "name": "Folate, food",
                    "rank": 7100,
                    "unitName": "µg"
                },
                "amount": 9.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385863,
                "nutrient": {
                    "id": 1190,
                    "number": "435",
                    "name": "Folate, DFE",
                    "rank": 7200,
                    "unitName": "µg"
                },
                "amount": 9.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385864,
                "nutrient": {
                    "id": 1242,
                    "number": "573",
                    "name": "Vitamin E, added",
                    "rank": 7920,
                    "unitName": "mg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385865,
                "nutrient": {
                    "id": 1246,
                    "number": "578",
                    "name": "Vitamin B-12, added",
                    "rank": 7340,
                    "unitName": "µg"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385866,
                "nutrient": {
                    "id": 1253,
                    "number": "601",
                    "name": "Cholesterol",
                    "rank": 15700,
                    "unitName": "mg"
                },
                "amount": 8.00
            },
            {
                "type": "FoodNutrient",
                "id": 34385867,
                "nutrient": {
                    "id": 1258,
                    "number": "606",
                    "name": "Fatty acids, total saturated",
                    "rank": 9700,
                    "unitName": "g"
                },
                "amount": 1.73
            },
            {
                "type": "FoodNutrient",
                "id": 34385868,
                "nutrient": {
                    "id": 1259,
                    "number": "607",
                    "name": "SFA 4:0",
                    "rank": 9800,
                    "unitName": "g"
                },
                "amount": 0.072
            },
            {
                "type": "FoodNutrient",
                "id": 34385869,
                "nutrient": {
                    "id": 1260,
                    "number": "608",
                    "name": "SFA 6:0",
                    "rank": 9900,
                    "unitName": "g"
                },
                "amount": 0.051
            },
            {
                "type": "FoodNutrient",
                "id": 34385870,
                "nutrient": {
                    "id": 1261,
                    "number": "609",
                    "name": "SFA 8:0",
                    "rank": 10000,
                    "unitName": "g"
                },
                "amount": 0.030
            },
            {
                "type": "FoodNutrient",
                "id": 34385871,
                "nutrient": {
                    "id": 1262,
                    "number": "610",
                    "name": "SFA 10:0",
                    "rank": 10100,
                    "unitName": "g"
                },
                "amount": 0.069
            },
            {
                "type": "FoodNutrient",
                "id": 34385872,
                "nutrient": {
                    "id": 1263,
                    "number": "611",
                    "name": "SFA 12:0",
                    "rank": 10300,
                    "unitName": "g"
                },
                "amount": 0.080
            },
            {
                "type": "FoodNutrient",
                "id": 34385873,
                "nutrient": {
                    "id": 1264,
                    "number": "612",
                    "name": "SFA 14:0",
                    "rank": 10500,
                    "unitName": "g"
                },
                "amount": 0.254
            },
            {
                "type": "FoodNutrient",
                "id": 34385874,
                "nutrient": {
                    "id": 1265,
                    "number": "613",
                    "name": "SFA 16:0",
                    "rank": 10700,
                    "unitName": "g"
                },
                "amount": 0.856
            },
            {
                "type": "FoodNutrient",
                "id": 34385875,
                "nutrient": {
                    "id": 1266,
                    "number": "614",
                    "name": "SFA 18:0",
                    "rank": 10900,
                    "unitName": "g"
                },
                "amount": 0.267
            },
            {
                "type": "FoodNutrient",
                "id": 34385876,
                "nutrient": {
                    "id": 1268,
                    "number": "617",
                    "name": "MUFA 18:1",
                    "rank": 12100,
                    "unitName": "g"
                },
                "amount": 0.553
            },
            {
                "type": "FoodNutrient",
                "id": 34385877,
                "nutrient": {
                    "id": 1269,
                    "number": "618",
                    "name": "PUFA 18:2",
                    "rank": 13100,
                    "unitName": "g"
                },
                "amount": 0.128
            },
            {
                "type": "FoodNutrient",
                "id": 34385878,
                "nutrient": {
                    "id": 1270,
                    "number": "619",
                    "name": "PUFA 18:3",
                    "rank": 13900,
                    "unitName": "g"
                },
                "amount": 0.040
            },
            {
                "type": "FoodNutrient",
                "id": 34385879,
                "nutrient": {
                    "id": 1271,
                    "number": "620",
                    "name": "PUFA 20:4",
                    "rank": 14700,
                    "unitName": "g"
                },
                "amount": 0.004
            },
            {
                "type": "FoodNutrient",
                "id": 34385880,
                "nutrient": {
                    "id": 1272,
                    "number": "621",
                    "name": "PUFA 22:6 n-3 (DHA)",
                    "rank": 15300,
                    "unitName": "g"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385881,
                "nutrient": {
                    "id": 1275,
                    "number": "626",
                    "name": "MUFA 16:1",
                    "rank": 11700,
                    "unitName": "g"
                },
                "amount": 0.046
            },
            {
                "type": "FoodNutrient",
                "id": 34385882,
                "nutrient": {
                    "id": 1276,
                    "number": "627",
                    "name": "PUFA 18:4",
                    "rank": 14250,
                    "unitName": "g"
                },
                "amount": 0.001
            },
            {
                "type": "FoodNutrient",
                "id": 34385883,
                "nutrient": {
                    "id": 1277,
                    "number": "628",
                    "name": "MUFA 20:1",
                    "rank": 12400,
                    "unitName": "g"
                },
                "amount": 0.004
            },
            {
                "type": "FoodNutrient",
                "id": 34385884,
                "nutrient": {
                    "id": 1278,
                    "number": "629",
                    "name": "PUFA 20:5 n-3 (EPA)",
                    "rank": 15000,
                    "unitName": "g"
                },
                "amount": 0.001
            },
            {
                "type": "FoodNutrient",
                "id": 34385885,
                "nutrient": {
                    "id": 1279,
                    "number": "630",
                    "name": "MUFA 22:1",
                    "rank": 12500,
                    "unitName": "g"
                },
                "amount": 0.000
            },
            {
                "type": "FoodNutrient",
                "id": 34385886,
                "nutrient": {
                    "id": 1280,
                    "number": "631",
                    "name": "PUFA 22:5 n-3 (DPA)",
                    "rank": 15200,
                    "unitName": "g"
                },
                "amount": 0.001
            },
            {
                "type": "FoodNutrient",
                "id": 34385887,
                "nutrient": {
                    "id": 1292,
                    "number": "645",
                    "name": "Fatty acids, total monounsaturated",
                    "rank": 11400,
                    "unitName": "g"
                },
                "amount": 0.630
            },
            {
                "type": "FoodNutrient",
                "id": 34385888,
                "nutrient": {
                    "id": 1293,
                    "number": "646",
                    "name": "Fatty acids, total polyunsaturated",
                    "rank": 12900,
                    "unitName": "g"
                },
                "amount": 0.166
            }
        ],
        "foodAttributes": [
            {
                "id": 3315929,
                "value": "fried",
                "foodAttributeType": {
                    "id": 1001,
                    "name": "Additional Description",
                    "description": "Additional descriptions for the food."
                },
                "rank": 2
            },
            {
                "id": 3322665,
                "value": "Moisture change: -15%",
                "foodAttributeType": {
                    "id": 1002,
                    "name": "Adjustments",
                    "description": "Adjustments made to foods, including moisture changes"
                }
            },
            {
                "id": 3305997,
                "name": "WWEIA Category number",
                "value": "6004",
                "foodAttributeType": {
                    "id": 999,
                    "name": "Attribute",
                    "description": "Generic attributes"
                }
            },
            {
                "id": 3305998,
                "name": "WWEIA Category description",
                "value": "Bananas",
                "foodAttributeType": {
                    "id": 999,
                    "name": "Attribute",
                    "description": "Generic attributes"
                }
            }
        ],
        "foodCode": "63107410",
        "startDate": "1/1/2021",
        "endDate": "12/31/2023",
        "wweiaFoodCategory": {
            "wweiaFoodCategoryDescription": "Bananas",
            "wweiaFoodCategoryCode": 3305998
        },
        "fdcId": 2709225,
        "dataType": "Survey (FNDDS)",
        "foodPortions": [
            {
                "id": 306108,
                "measureUnit": {
                    "id": 9999,
                    "name": "undetermined",
                    "abbreviation": "undetermined"
                },
                "modifier": "90000",
                "gramWeight": 140,
                "portionDescription": "Quantity not specified",
                "sequenceNumber": 3
            },
            {
                "id": 306106,
                "measureUnit": {
                    "id": 9999,
                    "name": "undetermined",
                    "abbreviation": "undetermined"
                },
                "modifier": "60343",
                "gramWeight": 140,
                "portionDescription": "1 banana",
                "sequenceNumber": 1
            },
            {
                "id": 306107,
                "measureUnit": {
                    "id": 9999,
                    "name": "undetermined",
                    "abbreviation": "undetermined"
                },
                "modifier": "10205",
                "gramWeight": 140,
                "portionDescription": "1 cup",
                "sequenceNumber": 2
            }
        ],
        "publicationDate": "10/31/2024",
        "inputFoods": [
            {
                "id": 138740,
                "unit": "GM",
                "portionDescription": "NONE",
                "portionCode": "0",
                "foodDescription": "Butter, stick, unsalted",
                "retentionCode": 0,
                "ingredientCode": 1145,
                "ingredientDescription": "Butter, stick, unsalted",
                "ingredientWeight": 3,
                "amount": 3,
                "sequenceNumber": 3
            },
            {
                "id": 138738,
                "unit": "GM",
                "portionDescription": "NONE",
                "portionCode": "0",
                "foodDescription": "Bananas, ripe and slightly ripe, raw",
                "retentionCode": 151,
                "ingredientCode": 9040,
                "ingredientDescription": "Bananas, ripe and slightly ripe, raw",
                "ingredientWeight": 90,
                "amount": 90,
                "sequenceNumber": 1
            },
            {
                "id": 138739,
                "unit": "GM",
                "portionDescription": "NONE",
                "portionCode": "0",
                "foodDescription": "Sugars, brown",
                "retentionCode": 0,
                "ingredientCode": 19334,
                "ingredientDescription": "Sugars, brown",
                "ingredientWeight": 7,
                "amount": 7,
                "sequenceNumber": 2
            }
        ]
    }
""".data(using: .utf8)!

let brandedFoodJSON =
"""
    {
        "discontinuedDate": "",
        "foodComponents": [],
        "foodAttributes": [],
        "foodPortions": [],
        "fdcId": 2643119,
        "description": "PEANUT BUTTER CUPS, PEANUT BUTTER",
        "publicationDate": "9/14/2023",
        "foodNutrients": [
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1004,
                    "number": "204",
                    "name": "Total lipid (fat)",
                    "rank": 800,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066663,
                "amount": 40.74000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1087,
                    "number": "301",
                    "name": "Calcium, Ca",
                    "rank": 5300,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066668,
                "amount": 74.00000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1253,
                    "number": "601",
                    "name": "Cholesterol",
                    "rank": 15700,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066674,
                "amount": 0E-8
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1093,
                    "number": "307",
                    "name": "Sodium, Na",
                    "rank": 5800,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066671,
                "amount": 130.00000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1114,
                    "number": "328",
                    "name": "Vitamin D (D2 + D3)",
                    "rank": 8700,
                    "unitName": "µg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066672,
                "amount": 0E-8
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1092,
                    "number": "306",
                    "name": "Potassium, K",
                    "rank": 5700,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066670,
                "amount": 148.00000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1089,
                    "number": "303",
                    "name": "Iron, Fe",
                    "rank": 5400,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066669,
                "amount": 1.85000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1003,
                    "number": "203",
                    "name": "Protein",
                    "rank": 600,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066662,
                "amount": 14.81000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1235,
                    "number": "539",
                    "name": "Sugars, added",
                    "rank": 1540,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066673,
                "amount": 0E-8
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2000,
                    "number": "269",
                    "name": "Total Sugars",
                    "rank": 1510,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 73,
                    "code": "LCSL",
                    "description": "Calculated from a less than value per serving size measure"
                },
                "id": 33066666,
                "amount": 3.70000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1257,
                    "number": "605",
                    "name": "Fatty acids, total trans",
                    "rank": 15400,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066675,
                "amount": 0E-8
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1005,
                    "number": "205",
                    "name": "Carbohydrate, by difference",
                    "rank": 1110,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066664,
                "amount": 40.74000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1079,
                    "number": "291",
                    "name": "Fiber, total dietary",
                    "rank": 1200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066667,
                "amount": 14.80000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1258,
                    "number": "606",
                    "name": "Fatty acids, total saturated",
                    "rank": 9700,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066676,
                "amount": 14.81000000
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1008,
                    "number": "208",
                    "name": "Energy",
                    "rank": 300,
                    "unitName": "kcal"
                },
                "foodNutrientDerivation": {
                    "id": 70,
                    "code": "LCCS",
                    "description": "Calculated from value per serving size measure"
                },
                "id": 33066665,
                "amount": 519.00000000
            }
        ],
        "dataType": "Branded",
        "foodClass": "Branded",
        "shortDescription": "",
        "modifiedDate": "8/21/2023",
        "availableDate": "8/21/2023",
        "brandOwner": "GoodSam",
        "brandName": "GOODSAM",
        "dataSource": "LI",
        "brandedFoodCategory": "Candy",
        "gtinUpc": "850014333416",
        "householdServingFullText": "3 Peanut Butter Cups",
        "ingredients": "PEANUT BUTTER^, ALLULOSE^, COCOA MASS*, COCOA BUTTER*, INULIN^, SUSTAINABLE ORGANIC PALM OIL+, SALT^ AND SUNFLOWER LECITHIN^",
        "marketCountry": "United States",
        "servingSize": 27.00000000,
        "servingSizeUnit": "GRM",
        "packageWeight": "4.7 oz/133 g",
        "foodUpdateLog": [
            {
                "discontinuedDate": "",
                "foodAttributes": [],
                "fdcId": 2643119,
                "description": "PEANUT BUTTER CUPS, PEANUT BUTTER",
                "publicationDate": "9/14/2023",
                "dataType": "Branded",
                "foodClass": "Branded",
                "shortDescription": "",
                "modifiedDate": "8/21/2023",
                "availableDate": "8/21/2023",
                "brandOwner": "GoodSam",
                "brandName": "GOODSAM",
                "dataSource": "LI",
                "brandedFoodCategory": "Candy",
                "gtinUpc": "850014333416",
                "householdServingFullText": "3 Peanut Butter Cups",
                "ingredients": "PEANUT BUTTER^, ALLULOSE^, COCOA MASS*, COCOA BUTTER*, INULIN^, SUSTAINABLE ORGANIC PALM OIL+, SALT^ AND SUNFLOWER LECITHIN^",
                "marketCountry": "United States",
                "servingSize": 27.00000000,
                "servingSizeUnit": "GRM",
                "packageWeight": "4.7 oz/133 g"
            }
        ],
        "labelNutrients": {
            "fat": {
                "value": 11.0
            },
            "saturatedFat": {
                "value": 4.00
            },
            "transFat": {
                "value": 0.000
            },
            "cholesterol": {
                "value": 0.000
            },
            "sodium": {
                "value": 35.1
            },
            "carbohydrates": {
                "value": 11.0
            },
            "fiber": {
                "value": 4.00
            },
            "sugars": {
                "value": 0.999
            },
            "protein": {
                "value": 4.00
            },
            "vitaminD": {
                "value": 0.000
            },
            "calcium": {
                "value": 20.0
            },
            "iron": {
                "value": 0.500
            },
            "potassium": {
                "value": 40.0
            },
            "addedSugar": {
                "value": 0.000
            },
            "calories": {
                "value": 140
            }
        }
    }
""".data(using: .utf8)!

let foundationFoodJSON =
"""
{
        "fdcId": 2262072,
        "description": "Peanut butter, creamy",
        "publicationDate": "4/28/2022",
        "foodNutrients": [
            {
                "nutrient": {
                    "id": 2045,
                    "number": "951",
                    "name": "Proximates",
                    "rank": 50,
                    "unitName": "g"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1051,
                    "number": "255",
                    "name": "Water",
                    "rank": 100,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795858,
                "amount": 1.10400000,
                "dataPoints": 8,
                "max": 1.46000000,
                "min": 0.59000000,
                "median": 1.10000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262991,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.12,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263044,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.59,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263097,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.08,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263151,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.965,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263204,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.27,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263257,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.46,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263311,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.955,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263365,
                        "nutrientId": 1051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.39,
                        "labMethodTechnique": "Vacuum oven",
                        "labMethodDescription": "AOAC 934.06 mod",
                        "labMethodOriginalDescription": "AOAC 934.06 (37.1.10) Moisture in Fruits, Vegetables, and their Products",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2047,
                    "number": "957",
                    "name": "Energy (Atwater General Factors)",
                    "rank": 280,
                    "unitName": "kcal"
                },
                "foodNutrientDerivation": {
                    "id": 49,
                    "code": "NC",
                    "description": "Calculated",
                    "foodNutrientSource": {
                        "id": 2,
                        "code": "4",
                        "description": "Calculated or imputed"
                    }
                },
                "id": 27795961,
                "amount": 631.65000000,
                "nutrientAnalysisDetails": []
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2048,
                    "number": "958",
                    "name": "Energy (Atwater Specific Factors)",
                    "rank": 290,
                    "unitName": "kcal"
                },
                "foodNutrientDerivation": {
                    "id": 49,
                    "code": "NC",
                    "description": "Calculated",
                    "foodNutrientSource": {
                        "id": 2,
                        "code": "4",
                        "description": "Calculated or imputed"
                    }
                },
                "id": 27795962,
                "amount": 589.38300600,
                "nutrientAnalysisDetails": []
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1002,
                    "number": "202",
                    "name": "Nitrogen",
                    "rank": 500,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795896,
                "amount": 4.39400000,
                "dataPoints": 8,
                "max": 4.64000000,
                "min": 4.24000000,
                "median": 4.37000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262992,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.39,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263045,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.42,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263098,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.32,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263152,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 4.35,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263205,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 4.33,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263258,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.24,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263312,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 4.46,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263366,
                        "nutrientId": 1002,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 4.64,
                        "labMethodTechnique": "Kjeldahl",
                        "labMethodDescription": "AOAC 991.20",
                        "labMethodOriginalDescription": "991.20 Nitrogen (Total) in Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1003,
                    "number": "203",
                    "name": "Protein",
                    "rank": 600,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 49,
                    "code": "NC",
                    "description": "Calculated",
                    "foodNutrientSource": {
                        "id": 2,
                        "code": "4",
                        "description": "Calculated or imputed"
                    }
                },
                "id": 27795959,
                "amount": 23.99124000,
                "max": 25.33440000,
                "min": 23.15040000,
                "median": 23.86020000,
                "nutrientAnalysisDetails": []
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1004,
                    "number": "204",
                    "name": "Total lipid (fat)",
                    "rank": 800,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795898,
                "amount": 49.43000000,
                "dataPoints": 8,
                "max": 54.24000000,
                "min": 33.51000000,
                "median": 52.04000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262975,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 52.85,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263028,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 51.48,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263081,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 54.24,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263135,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 48.93,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263188,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 53.37,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263241,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 52.6,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263295,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 33.51,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263349,
                        "nutrientId": 1004,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 48.49,
                        "labMethodTechnique": "Acid hydrolysis",
                        "labMethodDescription": "AOAC 989.05 mod",
                        "labMethodOriginalDescription": "Silliker modified 989.05 (33.2.26) Fat in Milk, Mojo, Acid Hydrolysis",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1007,
                    "number": "207",
                    "name": "Ash",
                    "rank": 1000,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795899,
                "amount": 2.77100000,
                "dataPoints": 8,
                "max": 3.39000000,
                "min": 2.12000000,
                "median": 2.79500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262967,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.91,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263020,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.07,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263073,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.24,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263127,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 2.12,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263180,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 3.25,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263233,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.39,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263287,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.68,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263341,
                        "nutrientId": 1007,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 2.51,
                        "labMethodTechnique": "Gravimetric",
                        "labMethodDescription": "AOAC 945.46",
                        "labMethodOriginalDescription": "945.46 Ash of Milk",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "nutrient": {
                    "id": 2039,
                    "number": "956",
                    "name": "Carbohydrates",
                    "rank": 1100,
                    "unitName": "g"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1005,
                    "number": "205",
                    "name": "Carbohydrate, by difference",
                    "rank": 1110,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 49,
                    "code": "NC",
                    "description": "Calculated",
                    "foodNutrientSource": {
                        "id": 2,
                        "code": "4",
                        "description": "Calculated or imputed"
                    }
                },
                "id": 27795960,
                "amount": 22.70376000,
                "nutrientAnalysisDetails": []
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1079,
                    "number": "291",
                    "name": "Fiber, total dietary",
                    "rank": 1200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795861,
                "amount": 6.32300000,
                "dataPoints": 8,
                "max": 6.77000000,
                "min": 6.01000000,
                "median": 6.28500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263003,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 6.01,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263056,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 6.44,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263109,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 6.03,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263163,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 6.715,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263216,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 6.05,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263269,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 6.16,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263323,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 6.77,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263377,
                        "nutrientId": 1079,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 6.41,
                        "labMethodTechnique": "Enzymatic-gravimetric",
                        "labMethodDescription": "AOAC 991.43",
                        "labMethodOriginalDescription": "991.43 (32.1.17) Total, Soluble, and Insoluble Dietary Fiber in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "nutrient": {
                    "id": 2043,
                    "number": "300",
                    "name": "Minerals",
                    "rank": 5200,
                    "unitName": "mg"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1087,
                    "number": "301",
                    "name": "Calcium, Ca",
                    "rank": 5300,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795869,
                "amount": 49.85000000,
                "dataPoints": 8,
                "max": 57.70000000,
                "min": 45.70000000,
                "median": 48.60000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262970,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 47.5,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263023,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 48.3,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263076,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 45.7,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263130,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 49.5,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263183,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 53.5,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263236,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 57.7,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263290,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 48.9,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263344,
                        "nutrientId": 1087,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 47.7,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1089,
                    "number": "303",
                    "name": "Iron, Fe",
                    "rank": 5400,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795871,
                "amount": 1.85300000,
                "dataPoints": 8,
                "max": 2.13000000,
                "min": 1.68000000,
                "median": 1.79000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262984,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.79,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263037,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.07,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263090,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.68,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263144,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.77,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263197,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.79,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263250,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.715,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263304,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.13,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263358,
                        "nutrientId": 1089,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.88,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1090,
                    "number": "304",
                    "name": "Magnesium, Mg",
                    "rank": 5500,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795873,
                "amount": 192.60000000,
                "dataPoints": 8,
                "max": 212.00000000,
                "min": 178.00000000,
                "median": 187.50000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262988,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 189.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263041,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 181.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263094,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 178.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263148,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 180.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263201,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 186.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263254,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 209.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263308,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 212.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263362,
                        "nutrientId": 1090,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 206.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1091,
                    "number": "305",
                    "name": "Phosphorus, P",
                    "rank": 5600,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795875,
                "amount": 393.20000000,
                "dataPoints": 8,
                "max": 471.50000000,
                "min": 359.00000000,
                "median": 384.00000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262994,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 383.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263047,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 379.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263100,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 385.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263154,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 370.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263207,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 411.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263260,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 471.5,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263314,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 387.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263368,
                        "nutrientId": 1091,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 359.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1092,
                    "number": "306",
                    "name": "Potassium, K",
                    "rank": 5700,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795878,
                "amount": 654.00000000,
                "dataPoints": 8,
                "max": 677.00000000,
                "min": 633.00000000,
                "median": 652.50000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262995,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 677.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263048,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 676.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263101,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 667.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263155,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 655.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263208,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 635.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263261,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 639.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263315,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 650.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263369,
                        "nutrientId": 1092,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 633.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1093,
                    "number": "307",
                    "name": "Sodium, Na",
                    "rank": 5800,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795880,
                "amount": 220.70000000,
                "dataPoints": 8,
                "max": 427.00000000,
                "min": 0E-8,
                "median": 231.50000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262999,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 284.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263052,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 315.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263105,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "loq": 4.9,
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263159,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "loq": 4.95,
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263212,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 427.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263265,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 408.5,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263319,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 179.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263373,
                        "nutrientId": 1093,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 152.0,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ],
                "loq": 4.95
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1095,
                    "number": "309",
                    "name": "Zinc, Zn",
                    "rank": 5900,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795883,
                "amount": 3.06200000,
                "dataPoints": 8,
                "max": 3.72000000,
                "min": 2.63500000,
                "median": 2.93500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263009,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.74,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263062,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.91,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263115,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.96,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263169,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 2.67,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263222,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 3.17,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263275,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.635,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263329,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 3.69,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263383,
                        "nutrientId": 1095,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 3.72,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1098,
                    "number": "312",
                    "name": "Copper, Cu",
                    "rank": 6000,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795886,
                "amount": 0.54050000,
                "dataPoints": 8,
                "max": 0.65500000,
                "min": 0.40200000,
                "median": 0.55050000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262971,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.505,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263024,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.402,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263077,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.417,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263131,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.635,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263184,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.523,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263237,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.578,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263291,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.655,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263345,
                        "nutrientId": 1098,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.609,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1101,
                    "number": "315",
                    "name": "Manganese, Mn",
                    "rank": 6100,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795890,
                "amount": 1.68100000,
                "dataPoints": 8,
                "max": 3.24000000,
                "min": 0.76900000,
                "median": 1.77000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262989,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.82,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263042,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.79,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263095,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.76,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263149,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.47,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263202,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.78,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263255,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.24,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263309,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.82,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263363,
                        "nutrientId": 1101,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.769,
                        "labMethodTechnique": "ICP",
                        "labMethodDescription": "AOAC 985.01 + 984.27",
                        "labMethodOriginalDescription": "Covance modified 985.01 (3.2.06) + 984.27 (50.1.15) Metals in Food by ICP",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1103,
                    "number": "317",
                    "name": "Selenium, Se",
                    "rank": 6200,
                    "unitName": "µg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795891,
                "amount": 20.16000000,
                "dataPoints": 8,
                "max": 65.90000000,
                "min": 3.72000000,
                "median": 7.20000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262997,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 8.67,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263050,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.8,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263103,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.13,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263157,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 19.1,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263210,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 3.72,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263263,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.73,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263317,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 65.9,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263371,
                        "nutrientId": 1103,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 49.2,
                        "labMethodTechnique": "ICP-MS",
                        "labMethodDescription": "AOAC 2011.19",
                        "labMethodOriginalDescription": "2011.19 (50.1.41) Chromium, Selenium, and Molybdenum in Infant Formula and Adult Nutritional Products (modified)",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "nutrient": {
                    "id": 2046,
                    "number": "952",
                    "name": "Vitamins and Other Components",
                    "rank": 6250,
                    "unitName": "g"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1165,
                    "number": "404",
                    "name": "Thiamin",
                    "rank": 6400,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795852,
                "amount": 0.12060000,
                "dataPoints": 8,
                "max": 0.17400000,
                "min": 0.08250000,
                "median": 0.11350000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263008,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.137,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263061,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.116,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263114,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.105,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263168,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.084,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263221,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.111,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263274,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0825,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263328,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.174,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263382,
                        "nutrientId": 1165,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.155,
                        "labMethodTechnique": "Fluorometric",
                        "labMethodDescription": "AOAC 942.23",
                        "labMethodOriginalDescription": "942.23 Thiamine (B1) in Foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1167,
                    "number": "406",
                    "name": "Niacin",
                    "rank": 6600,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795853,
                "amount": 17.20000000,
                "dataPoints": 8,
                "max": 22.95000000,
                "min": 15.20000000,
                "median": 16.48000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263872,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 15.3,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263873,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 16.3,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263874,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 17.5,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263875,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 16.45,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263877,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 17.4,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263878,
                        "nutrientId": 1167,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 16.5,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1175,
                    "number": "415",
                    "name": "Vitamin B-6",
                    "rank": 6800,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795855,
                "amount": 0.38050000,
                "dataPoints": 8,
                "max": 0.46500000,
                "min": 0.31600000,
                "median": 0.36350000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263839,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.415,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263840,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.434,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263841,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.465,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263842,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.342,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 944.13 + 960.46 + 985.34",
                        "labMethodOriginalDescription": "Covance modified 944.13 (45.2.04) & 960.46 (45.2.01) & 985.34 (50.1.19) Niacin in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263843,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.316,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263844,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.364,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263845,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.363,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263846,
                        "nutrientId": 1175,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.345,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 961.15",
                        "labMethodOriginalDescription": "Covance modified 961.15 (45.2.08) Vitamin B6 (Pyridoxine, Pyridoxal, and Pyridoxamine) in Food Extracts",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1176,
                    "number": "416",
                    "name": "Biotin",
                    "rank": 6850,
                    "unitName": "µg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795856,
                "amount": 87.81000000,
                "dataPoints": 8,
                "max": 94.65000000,
                "min": 78.35000000,
                "median": 89.05000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262969,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 93.6,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263022,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 92.15,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263075,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 89.6,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263129,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 88.5,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263182,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 80.7,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263235,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 78.35,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263289,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 84.9,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    },
                    {
                        "subSampleId": 2263343,
                        "nutrientId": 1176,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 94.65,
                        "labMethodTechnique": "Nephelometry",
                        "labMethodDescription": "doi.org/10.1002/jps.2600560249",
                        "labMethodOriginalDescription": "Methods of vitamin assay. 3rd ed. Edited by The Association of Vitamin Chemists, Inc., Methods Committee. John Wiley & Sons, Inc., 605 Third Ave., New York, N. Y. 10016, 1966",
                        "labMethodLink": "https://onlinelibrary.wiley.com/doi/abs/10.1002/jps.2600560249"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1177,
                    "number": "417",
                    "name": "Folate, total",
                    "rank": 6900,
                    "unitName": "µg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795857,
                "amount": 97.29000000,
                "dataPoints": 8,
                "max": 116.10000000,
                "min": 69.10000000,
                "median": 100.40000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262976,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 113.0,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263029,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 98.5,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263082,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 104.5,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263242,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 69.1,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263296,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 82.5,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263350,
                        "nutrientId": 1177,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 92.3,
                        "labMethodTechnique": "Microbiological",
                        "labMethodDescription": "AOAC 992.05",
                        "labMethodOriginalDescription": "Covance modified 992.15 (50.1.21) & 960.46 (45.2.01) & Infant Formula Council & Am J Clin Nutr 21:1202 (1968) Total folate",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1109,
                    "number": "323",
                    "name": "Vitamin E (alpha-tocopherol)",
                    "rank": 7905,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795893,
                "amount": 5.41300000,
                "dataPoints": 8,
                "max": 7.55000000,
                "min": 3.84000000,
                "median": 5.17000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263814,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.45,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263815,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.17,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263816,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.42,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263817,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 7.55,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263818,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 4.31,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263819,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.84,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263820,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 5.17,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263821,
                        "nutrientId": 1109,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 7.39,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "In-house HPLC retinol",
                        "labMethodOriginalDescription": "Craft retinol method - HPLC, NP, UV & fluorescent detection with external calib., int std recovery post analysis",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1185,
                    "number": "430",
                    "name": "Vitamin K (phylloquinone)",
                    "rank": 8800,
                    "unitName": "µg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 28913793,
                "amount": 0E-8,
                "dataPoints": 8,
                "max": 0E-8,
                "min": 0E-8,
                "median": 0E-8,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2352926,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352927,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352928,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352929,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352930,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352931,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352932,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    },
                    {
                        "subSampleId": 2352933,
                        "nutrientId": 1185,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "doi.org/10.1016/S0076-6879(97)82128-3",
                        "labMethodOriginalDescription": "Booth & Sadowski, Methods Enzymol., 282 (1997) p446",
                        "loq": 0.1,
                        "labMethodLink": "https://www.sciencedirect.com/science/article/pii/S0076687997821283"
                    }
                ],
                "loq": 0.1
            },
            {
                "nutrient": {
                    "id": 2044,
                    "number": "950",
                    "name": "Lipids",
                    "rank": 9600,
                    "unitName": "g"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1258,
                    "number": "606",
                    "name": "Fatty acids, total saturated",
                    "rank": 9700,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795897,
                "amount": 8.41500000,
                "dataPoints": 8,
                "max": 10.01000000,
                "min": 6.10000000,
                "median": 9.35500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263004,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 9.46,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263057,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 9.25,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263110,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 9.62,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263164,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 6.1,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263217,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 9.53,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263270,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 10.01,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263324,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 6.55,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263378,
                        "nutrientId": 1258,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 6.8,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1265,
                    "number": "613",
                    "name": "SFA 16:0",
                    "rank": 10700,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795900,
                "amount": 4.10600000,
                "dataPoints": 8,
                "max": 5.05900000,
                "min": 2.52400000,
                "median": 4.78500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262957,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.805,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263010,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.764,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263063,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 4.979,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263116,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 2.524,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263170,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 5.013,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263223,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.059,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263276,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.87,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263330,
                        "nutrientId": 1265,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 2.83,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1266,
                    "number": "614",
                    "name": "SFA 18:0",
                    "rank": 10900,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795901,
                "amount": 1.29300000,
                "dataPoints": 8,
                "max": 1.94800000,
                "min": 0.78300000,
                "median": 1.34100000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262958,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.504,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263011,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.45,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263064,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.405,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263117,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.783,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263171,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.277,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263224,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.948,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263277,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.891,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263331,
                        "nutrientId": 1266,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.089,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1267,
                    "number": "615",
                    "name": "SFA 20:0",
                    "rank": 11100,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795902,
                "amount": 0.68260000,
                "dataPoints": 8,
                "max": 0.96000000,
                "min": 0.47800000,
                "median": 0.71050000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262961,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.719,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263014,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.702,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263067,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.736,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263120,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.478,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263174,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.739,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263227,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.96,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263280,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.553,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263334,
                        "nutrientId": 1267,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.574,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1273,
                    "number": "624",
                    "name": "SFA 22:0",
                    "rank": 11200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795903,
                "amount": 1.42400000,
                "dataPoints": 8,
                "max": 1.58300000,
                "min": 1.26100000,
                "median": 1.42000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262963,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.546,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263016,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.48,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263069,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.562,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263122,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.277,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263176,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.583,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263229,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.359,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263282,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.261,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263336,
                        "nutrientId": 1273,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.322,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1301,
                    "number": "654",
                    "name": "SFA 24:0",
                    "rank": 11300,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795854,
                "amount": 0.82430000,
                "dataPoints": 8,
                "max": 0.96700000,
                "min": 0.60200000,
                "median": 0.81600000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262964,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.809,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263017,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.77,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263070,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.809,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263124,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.967,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263177,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.823,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263230,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.602,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263284,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.907,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263338,
                        "nutrientId": 1301,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.907,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1292,
                    "number": "645",
                    "name": "Fatty acids, total monounsaturated",
                    "rank": 11400,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795850,
                "amount": 30.71000000,
                "dataPoints": 8,
                "max": 37.92000000,
                "min": 19.30000000,
                "median": 28.89000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263001,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 27.63,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263054,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 28.77,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263107,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 29.01,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263161,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 37.92,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263214,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 27.56,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263267,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 19.3,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263321,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 37.76,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263375,
                        "nutrientId": 1292,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 37.73,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1315,
                    "number": "674",
                    "name": "MUFA 18:1 c",
                    "rank": 12200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795859,
                "amount": 29.76000000,
                "dataPoints": 8,
                "max": 36.53000000,
                "min": 18.82000000,
                "median": 28.13000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262959,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 26.855,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263012,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 28.003,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263065,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 28.257,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263118,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 36.31,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263172,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 26.818,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263225,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 18.822,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263278,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 36.534,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263332,
                        "nutrientId": 1315,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 36.472,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2012,
                    "number": "829",
                    "name": "MUFA 20:1 c",
                    "rank": 12401,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795894,
                "amount": 0.80060000,
                "dataPoints": 8,
                "max": 1.33900000,
                "min": 0.41900000,
                "median": 0.65500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262962,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.664,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263015,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.646,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263068,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.634,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263121,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.339,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263175,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.63,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263228,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.419,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263281,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.024,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263335,
                        "nutrientId": 2012,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.049,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2014,
                    "number": "676.1",
                    "name": "MUFA 22:1 n-9",
                    "rank": 12601,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795895,
                "amount": 0.13200000,
                "dataPoints": 3,
                "max": 0.17200000,
                "min": 0.11000000,
                "median": 0.11400000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263123,
                        "nutrientId": 2014,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.172,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263283,
                        "nutrientId": 2014,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.11,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263337,
                        "nutrientId": 2014,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.114,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1293,
                    "number": "646",
                    "name": "Fatty acids, total polyunsaturated",
                    "rank": 12900,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795851,
                "amount": 9.78100000,
                "dataPoints": 8,
                "max": 19.40000000,
                "min": 2.50000000,
                "median": 12.51000000,
                "minYearAcquired": 2022,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263002,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.67,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263055,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.35,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263108,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.84,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263162,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 2.66,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263215,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 13.31,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263268,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 19.4,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263322,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.5,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263376,
                        "nutrientId": 1293,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 2.52,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1316,
                    "number": "675",
                    "name": "PUFA 18:2 n-6 c,c",
                    "rank": 13200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795860,
                "amount": 9.73300000,
                "dataPoints": 8,
                "max": 19.34000000,
                "min": 2.45700000,
                "median": 12.47000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262960,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.621,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263013,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.309,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263066,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.798,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263119,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 2.598,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263173,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 13.265,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263226,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 19.34,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263279,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.457,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    },
                    {
                        "subSampleId": 2263333,
                        "nutrientId": 1316,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 2.479,
                        "labMethodTechnique": "GLC",
                        "labMethodDescription": "AOAC 996.06",
                        "labMethodOriginalDescription": "996.06 (41.1.28A) Fat (Total, Saturated and Monounsaturated) in foods",
                        "labMethodLink": "https://doi.org/10.1093/9780197610145.001.0001"
                    }
                ]
            },
            {
                "nutrient": {
                    "id": 2042,
                    "number": "500",
                    "name": "Amino acids",
                    "rank": 16250,
                    "unitName": "g"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1210,
                    "number": "501",
                    "name": "Tryptophan",
                    "rank": 16300,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795862,
                "amount": 0.22880000,
                "dataPoints": 8,
                "max": 0.24000000,
                "min": 0.22000000,
                "median": 0.23000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263005,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263058,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.24,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263111,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263165,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263218,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.22,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263271,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.22,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263325,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263379,
                        "nutrientId": 1210,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1211,
                    "number": "502",
                    "name": "Threonine",
                    "rank": 16400,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795863,
                "amount": 0.80630000,
                "dataPoints": 8,
                "max": 0.92000000,
                "min": 0.76000000,
                "median": 0.78000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263000,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.78,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263053,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.76,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263106,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.78,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263160,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.77,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263213,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.78,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263266,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.78,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263320,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.88,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263374,
                        "nutrientId": 1211,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.92,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1212,
                    "number": "503",
                    "name": "Isoleucine",
                    "rank": 16500,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795865,
                "amount": 0.92000000,
                "dataPoints": 8,
                "max": 1.04000000,
                "min": 0.87000000,
                "median": 0.90500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262985,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.88,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263038,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.87,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263091,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.87,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263145,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.9,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263198,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.91,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263251,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.91,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263305,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.98,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263359,
                        "nutrientId": 1212,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.04,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1213,
                    "number": "504",
                    "name": "Leucine",
                    "rank": 16600,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795867,
                "amount": 1.88100000,
                "dataPoints": 8,
                "max": 2.08000000,
                "min": 1.81000000,
                "median": 1.84000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262986,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.84,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263039,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.82,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263092,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.81,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263146,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.82,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263199,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.87,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263252,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.84,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263306,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.97,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263360,
                        "nutrientId": 1213,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 2.08,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1214,
                    "number": "505",
                    "name": "Lysine",
                    "rank": 16700,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795868,
                "amount": 0.95130000,
                "dataPoints": 8,
                "max": 1.03000000,
                "min": 0.89000000,
                "median": 0.95500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262987,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.97,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263040,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.89,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263093,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.94,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263147,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.91,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263200,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.97,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263253,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.89,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263307,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.01,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263361,
                        "nutrientId": 1214,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.03,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1215,
                    "number": "506",
                    "name": "Methionine",
                    "rank": 16800,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795870,
                "amount": 0.29000000,
                "dataPoints": 8,
                "max": 0.33000000,
                "min": 0.24000000,
                "median": 0.28500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262990,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.28,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263043,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.28,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263096,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.28,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263150,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.24,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263203,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.29,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263256,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.33,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263310,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.31,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263364,
                        "nutrientId": 1215,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.31,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1217,
                    "number": "508",
                    "name": "Phenylalanine",
                    "rank": 17000,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795872,
                "amount": 1.50100000,
                "dataPoints": 8,
                "max": 1.67000000,
                "min": 1.43000000,
                "median": 1.46500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262993,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.47,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263046,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.46,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263099,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.45,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263153,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.43,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263206,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.48,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263259,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.46,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263313,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.59,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263367,
                        "nutrientId": 1217,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.67,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1218,
                    "number": "509",
                    "name": "Tyrosine",
                    "rank": 17100,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795874,
                "amount": 1.06400000,
                "dataPoints": 8,
                "max": 1.20000000,
                "min": 1.00000000,
                "median": 1.04000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263006,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.02,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263059,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.04,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263112,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.04,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263166,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263219,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.06,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263272,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.03,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263326,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.12,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263380,
                        "nutrientId": 1218,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.2,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1219,
                    "number": "510",
                    "name": "Valine",
                    "rank": 17200,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795876,
                "amount": 1.11600000,
                "dataPoints": 8,
                "max": 1.29000000,
                "min": 1.03000000,
                "median": 1.08000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2263007,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.05,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263060,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.06,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263113,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.05,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263167,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.03,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263220,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.12,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263273,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.1,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263327,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263381,
                        "nutrientId": 1219,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.29,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1220,
                    "number": "511",
                    "name": "Arginine",
                    "rank": 17300,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795877,
                "amount": 3.32300000,
                "dataPoints": 8,
                "max": 3.65000000,
                "min": 3.22000000,
                "median": 3.27000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262966,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.22,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263019,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.24,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263072,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263126,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 3.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263179,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 3.3,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263232,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.3,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263286,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 3.41,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263340,
                        "nutrientId": 1220,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 3.65,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1221,
                    "number": "512",
                    "name": "Histidine",
                    "rank": 17400,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795879,
                "amount": 0.67630000,
                "dataPoints": 8,
                "max": 0.76000000,
                "min": 0.61000000,
                "median": 0.66000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262982,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.66,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263035,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.65,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263088,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.61,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263142,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.65,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263195,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.69,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263248,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.66,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263302,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.73,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263356,
                        "nutrientId": 1221,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.76,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1222,
                    "number": "513",
                    "name": "Alanine",
                    "rank": 17500,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795881,
                "amount": 1.16000000,
                "dataPoints": 8,
                "max": 1.32000000,
                "min": 1.09000000,
                "median": 1.13000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262965,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.1,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263018,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.09,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263071,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.1,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263125,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.14,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263178,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.16,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263231,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.12,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263285,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.25,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263339,
                        "nutrientId": 1222,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.32,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1223,
                    "number": "514",
                    "name": "Aspartic acid",
                    "rank": 17600,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795882,
                "amount": 3.41500000,
                "dataPoints": 8,
                "max": 3.84000000,
                "min": 3.27000000,
                "median": 3.32500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262968,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.33,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263021,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.28,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263074,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.31,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263128,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 3.32,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263181,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 3.36,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263234,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 3.27,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263288,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 3.61,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263342,
                        "nutrientId": 1223,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 3.84,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1224,
                    "number": "515",
                    "name": "Glutamic acid",
                    "rank": 17700,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795884,
                "amount": 5.81900000,
                "dataPoints": 8,
                "max": 6.47000000,
                "min": 5.53000000,
                "median": 5.68500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262979,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.7,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263032,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.58,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263085,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.67,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263139,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 5.53,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263192,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 5.83,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263245,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 5.65,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263299,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 6.12,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263353,
                        "nutrientId": 1224,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 6.47,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1225,
                    "number": "516",
                    "name": "Glycine",
                    "rank": 17800,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795885,
                "amount": 1.69000000,
                "dataPoints": 8,
                "max": 1.76000000,
                "min": 1.51000000,
                "median": 1.71000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262980,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.71,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263033,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.68,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263086,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.71,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263140,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.69,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263193,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.72,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263246,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.51,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263300,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.74,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263354,
                        "nutrientId": 1225,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.76,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1226,
                    "number": "517",
                    "name": "Proline",
                    "rank": 17900,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795887,
                "amount": 1.24400000,
                "dataPoints": 8,
                "max": 1.33000000,
                "min": 1.16000000,
                "median": 1.24500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262996,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.26,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263049,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.25,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263102,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.24,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263156,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.23,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263209,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.22,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263262,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.16,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263316,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.26,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263370,
                        "nutrientId": 1226,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.33,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1227,
                    "number": "518",
                    "name": "Serine",
                    "rank": 18000,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795888,
                "amount": 1.42300000,
                "dataPoints": 8,
                "max": 1.59000000,
                "min": 1.36000000,
                "median": 1.38500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262998,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.39,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263051,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.37,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263104,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.37,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263158,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.36,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263211,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.4,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263264,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.38,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263318,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 1.52,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263372,
                        "nutrientId": 1227,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.59,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1228,
                    "number": "521",
                    "name": "Hydroxyproline",
                    "rank": 18100,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795889,
                "amount": 0.16250000,
                "dataPoints": 8,
                "max": 0.20000000,
                "min": 0.12000000,
                "median": 0.16500000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262983,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.15,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263036,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.12,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263089,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.13,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263143,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.13,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263196,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.19,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263249,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.18,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263303,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.2,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263357,
                        "nutrientId": 1228,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.2,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1232,
                    "number": "526",
                    "name": "Cysteine",
                    "rank": 18150,
                    "unitName": "g"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795892,
                "amount": 0.51380000,
                "dataPoints": 8,
                "max": 0.56000000,
                "min": 0.46000000,
                "median": 0.51000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262972,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.54,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263025,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.53,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263078,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.56,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263132,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.51,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263185,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.49,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263238,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.51,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263292,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.51,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    },
                    {
                        "subSampleId": 2263346,
                        "nutrientId": 1232,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.46,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "USDA Guidebook 1986",
                        "labMethodOriginalDescription": "USDA Guidebook 1986, Method 6.011",
                        "labMethodLink": "https://www.aoac.org/official-methods-of-analysis-21st-edition-2019/"
                    }
                ]
            },
            {
                "nutrient": {
                    "id": 1343,
                    "number": "713",
                    "name": "Isoflavones",
                    "rank": 19000,
                    "unitName": "mg"
                },
                "type": "FoodNutrient"
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1340,
                    "number": "710",
                    "name": "Daidzein",
                    "rank": 19100,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795864,
                "amount": 11.46000000,
                "dataPoints": 8,
                "max": 16.20000000,
                "min": 7.28000000,
                "median": 11.80000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262973,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 9.27,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263026,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 13.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263079,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 12.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263133,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 10.08,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263186,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 11.6,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263239,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 16.2,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263293,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 12.25,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263347,
                        "nutrientId": 1340,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 7.28,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 1341,
                    "number": "711",
                    "name": "Genistein",
                    "rank": 19200,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795866,
                "amount": 0E-8,
                "dataPoints": 8,
                "max": 0E-8,
                "min": 0E-8,
                "median": 0E-8,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262977,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263030,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263083,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263137,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263190,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263243,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263297,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263351,
                        "nutrientId": 1341,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.0,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "loq": 0.013,
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    }
                ],
                "loq": 0.013
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2049,
                    "number": "717",
                    "name": "Daidzin",
                    "rank": 19310,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795847,
                "amount": 0.64930000,
                "dataPoints": 8,
                "max": 1.19500000,
                "min": 0.29600000,
                "median": 0.60450000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262974,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.673,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263027,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.543,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263080,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.044,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263134,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.357,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263187,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.296,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263240,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.195,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263294,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.42,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263348,
                        "nutrientId": 2049,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.666,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2050,
                    "number": "718",
                    "name": "Genistin",
                    "rank": 19320,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795848,
                "amount": 1.93200000,
                "dataPoints": 8,
                "max": 2.49000000,
                "min": 1.39500000,
                "median": 1.93000000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262978,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.89,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263031,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 1.515,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263084,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.24,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263138,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 1.395,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263191,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 1.97,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263244,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 2.49,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263298,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 2.155,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263352,
                        "nutrientId": 2050,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 1.8,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    }
                ]
            },
            {
                "type": "FoodNutrient",
                "nutrient": {
                    "id": 2051,
                    "number": "719",
                    "name": "Glycitin",
                    "rank": 19330,
                    "unitName": "mg"
                },
                "foodNutrientDerivation": {
                    "id": 1,
                    "code": "A",
                    "description": "Analytical",
                    "foodNutrientSource": {
                        "id": 1,
                        "code": "1",
                        "description": "Analytical or derived from analytical"
                    }
                },
                "id": 27795849,
                "amount": 0.41250000,
                "dataPoints": 8,
                "max": 0.54000000,
                "min": 0.26000000,
                "median": 0.39750000,
                "minYearAcquired": 2021,
                "nutrientAnalysisDetails": [
                    {
                        "subSampleId": 2262981,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262076,
                                "purchaseDate": "8/12/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.51,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263034,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262078,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Orrville",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.26,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263087,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262080,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Plain City",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.36,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263141,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262082,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Nunda",
                                "packerState": "NY"
                            }
                        ],
                        "amount": 0.295,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263194,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262084,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Matthews",
                                "packerState": "NC"
                            }
                        ],
                        "amount": 0.54,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263247,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262086,
                                "purchaseDate": "6/27/2021",
                                "storeCity": "Ellicott City",
                                "storeState": "MD",
                                "packerCity": "Cincinnati",
                                "packerState": "OH"
                            }
                        ],
                        "amount": 0.54,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263301,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262088,
                                "purchaseDate": "6/28/2021",
                                "storeCity": "Jessup",
                                "storeState": "MD",
                                "packerCity": "Chico",
                                "packerState": "CA"
                            }
                        ],
                        "amount": 0.385,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    },
                    {
                        "subSampleId": 2263355,
                        "nutrientId": 2051,
                        "nutrientAcquisitionDetails": [
                            {
                                "sampleUnitId": 2262090,
                                "purchaseDate": "8/5/2021",
                                "storeCity": "Blacksburg",
                                "storeState": "VA",
                                "packerCity": "Grand Rapids",
                                "packerState": "MI"
                            }
                        ],
                        "amount": 0.41,
                        "labMethodTechnique": "HPLC",
                        "labMethodDescription": "AOAC 2001.10",
                        "labMethodOriginalDescription": "AOAC Official Method 2001.10, Determination of Isoflavones in Soy and Selected Foods Containing Soy",
                        "labMethodLink": "https://doi.org/10.1016/j.chroma.2005.11.060"
                    }
                ]
            }
        ],
        "dataType": "Foundation",
        "foodClass": "FinalFood",
        "inputFoods": [
            {
                "id": 104021,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262079,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104023,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262081,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104027,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262077,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104037,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262087,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104038,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262089,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104039,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262083,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104041,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262085,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            },
            {
                "id": 104043,
                "foodDescription": "peanut butter, creamy",
                "inputFood": {
                    "fdcId": 2262091,
                    "description": "peanut butter, creamy",
                    "publicationDate": "4/28/2022",
                    "foodAttributeTypes": [],
                    "foodClass": "Composite",
                    "totalRefuse": 0,
                    "dataType": "Sample",
                    "foodGroup": {
                        "id": 16,
                        "code": "1600",
                        "description": "Legumes and Legume Products"
                    }
                }
            }
        ],
        "foodComponents": [],
        "foodAttributes": [],
        "nutrientConversionFactors": [
            {
                "id": 22886,
                "proteinValue": 3.47000000,
                "fatValue": 8.37000000,
                "carbohydrateValue": 4.07000000,
                "type": ".CalorieConversionFactor",
                "name": "Calories From Proximates"
            },
            {
                "id": 22890,
                "value": 5.46000000,
                "type": ".ProteinConversionFactor",
                "name": "Protein From Nitrogen"
            }
        ],
        "ndbNumber": 16098,
        "isHistoricalReference": false,
        "foodCategory": {
            "id": 16,
            "code": "1600",
            "description": "Legumes and Legume Products"
        }
    }
""".data(using: .utf8)!

let foodSearchResponseJSON =
"""
{
    "totalHits": 5134,
    "currentPage": 1,
    "totalPages": 5134,
    "pageList": [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
    ],
    "foodSearchCriteria": {
        "dataType": [
            "Branded",
            "SR Legacy",
            "Foundation"
        ],
        "query": "banana",
        "generalSearchInput": "banana",
        "pageNumber": 1,
        "numberOfResultsPerPage": 50,
        "pageSize": 1,
        "requireAllWords": false,
        "foodTypes": [
            "Branded",
            "SR Legacy",
            "Foundation"
        ]
    },
    "foods": [
        {
            "fdcId": 2012128,
            "description": "BANANA",
            "dataType": "Branded",
            "gtinUpc": "016459200441",
            "publishedDate": "2021-10-28",
            "brandOwner": "Wonder Natural Foods Corp",
            "brandName": "BETTER'N PEANUT BUTTER",
            "ingredients": "PEANUTS (AS DEFATTED PEANUT FLOUR, PEANUT BUTTER AND NATURAL PEANUT OILS), PURE WATER, TAPIOCA SYRUP, RICE SYRUP, VEGETABLE GLYCERINE, CANE SUGAR, BANANA, NATURAL COLORS AND FLAVORS, SALT, CALCIUM CARBONATE, LECITHIN, TOCOPHEROL (VITAMIN E), SODIUM ASCORBATE (VITAMIN C).",
            "marketCountry": "United States",
            "foodCategory": "Nut & Seed Butters",
            "modifiedDate": "2018-06-29",
            "dataSource": "LI",
            "packageWeight": "16 oz/1 lbs/454 g",
            "servingSizeUnit": "g",
            "servingSize": 32.0,
            "householdServingFullText": "2 Tbsp",
            "tradeChannels": [
                "NO_TRADE_CHANNEL"
            ],
            "allHighlightFields": "<b>Ingredients</b>:  SYRUP, RICE SYRUP, VEGETABLE GLYCERINE, CANE SUGAR, <em>BANANA</em>, NATURAL COLORS AND FLAVORS, SALT, CALCIUM",
            "score": 1077.576,
            "microbes": [],
            "foodNutrients": [
                {
                    "nutrientId": 1003,
                    "nutrientName": "Protein",
                    "nutrientNumber": "203",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 12.5,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 600,
                    "indentLevel": 1,
                    "foodNutrientId": 26035654
                },
                {
                    "nutrientId": 1004,
                    "nutrientName": "Total lipid (fat)",
                    "nutrientNumber": "204",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 6.25,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 800,
                    "indentLevel": 1,
                    "foodNutrientId": 26035655,
                    "percentDailyValue": 3
                },
                {
                    "nutrientId": 1005,
                    "nutrientName": "Carbohydrate, by difference",
                    "nutrientNumber": "205",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 40.6,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 1110,
                    "indentLevel": 2,
                    "foodNutrientId": 26035656,
                    "percentDailyValue": 4
                },
                {
                    "nutrientId": 1008,
                    "nutrientName": "Energy",
                    "nutrientNumber": "208",
                    "unitName": "KCAL",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 312,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 300,
                    "indentLevel": 1,
                    "foodNutrientId": 26035657
                },
                {
                    "nutrientId": 2000,
                    "nutrientName": "Total Sugars",
                    "nutrientNumber": "269",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 6.25,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 1510,
                    "indentLevel": 3,
                    "foodNutrientId": 26035658
                },
                {
                    "nutrientId": 1079,
                    "nutrientName": "Fiber, total dietary",
                    "nutrientNumber": "291",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 6.2,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 1200,
                    "indentLevel": 3,
                    "foodNutrientId": 26035659,
                    "percentDailyValue": 8
                },
                {
                    "nutrientId": 1087,
                    "nutrientName": "Calcium, Ca",
                    "nutrientNumber": "301",
                    "unitName": "MG",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 125,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 5300,
                    "indentLevel": 1,
                    "foodNutrientId": 26035660,
                    "percentDailyValue": 4
                },
                {
                    "nutrientId": 1089,
                    "nutrientName": "Iron, Fe",
                    "nutrientNumber": "303",
                    "unitName": "MG",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 1.12,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 5400,
                    "indentLevel": 1,
                    "foodNutrientId": 26035661,
                    "percentDailyValue": 2
                },
                {
                    "nutrientId": 1093,
                    "nutrientName": "Sodium, Na",
                    "nutrientNumber": "307",
                    "unitName": "MG",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 594,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 5800,
                    "indentLevel": 1,
                    "foodNutrientId": 26035662,
                    "percentDailyValue": 8
                },
                {
                    "nutrientId": 1104,
                    "nutrientName": "Vitamin A, IU",
                    "nutrientNumber": "318",
                    "unitName": "IU",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 0.0,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 7500,
                    "indentLevel": 1,
                    "foodNutrientId": 26035663,
                    "percentDailyValue": 0
                },
                {
                    "nutrientId": 1162,
                    "nutrientName": "Vitamin C, total ascorbic acid",
                    "nutrientNumber": "401",
                    "unitName": "MG",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 15.0,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 6300,
                    "indentLevel": 1,
                    "foodNutrientId": 26035664,
                    "percentDailyValue": 8
                },
                {
                    "nutrientId": 1253,
                    "nutrientName": "Cholesterol",
                    "nutrientNumber": "601",
                    "unitName": "MG",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 0.0,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 15700,
                    "indentLevel": 1,
                    "foodNutrientId": 26035665,
                    "percentDailyValue": 0
                },
                {
                    "nutrientId": 1257,
                    "nutrientName": "Fatty acids, total trans",
                    "nutrientNumber": "605",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 0.0,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 15400,
                    "indentLevel": 1,
                    "foodNutrientId": 26035666
                },
                {
                    "nutrientId": 1258,
                    "nutrientName": "Fatty acids, total saturated",
                    "nutrientNumber": "606",
                    "unitName": "G",
                    "derivationCode": "LCCD",
                    "derivationDescription": "Calculated from a daily value percentage per serving size measure",
                    "derivationId": 75,
                    "value": 0.0,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 9700,
                    "indentLevel": 1,
                    "foodNutrientId": 26035667,
                    "percentDailyValue": 0
                },
                {
                    "nutrientId": 1292,
                    "nutrientName": "Fatty acids, total monounsaturated",
                    "nutrientNumber": "645",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 3.12,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 11400,
                    "indentLevel": 1,
                    "foodNutrientId": 26035668
                },
                {
                    "nutrientId": 1293,
                    "nutrientName": "Fatty acids, total polyunsaturated",
                    "nutrientNumber": "646",
                    "unitName": "G",
                    "derivationCode": "LCCS",
                    "derivationDescription": "Calculated from value per serving size measure",
                    "derivationId": 70,
                    "value": 3.12,
                    "foodNutrientSourceId": 9,
                    "foodNutrientSourceCode": "12",
                    "foodNutrientSourceDescription": "Manufacturer's analytical; partial documentation",
                    "rank": 12900,
                    "indentLevel": 1,
                    "foodNutrientId": 26035669
                }
            ],
            "finalFoodInputFoods": [],
            "foodMeasures": [],
            "foodAttributes": [],
            "foodAttributeTypes": [],
            "foodVersionIds": []
        }
    ],
    "aggregations": {
        "dataType": {
            "Branded": 5074,
            "SR Legacy": 58,
            "Survey (FNDDS)": 22,
            "Experimental": 2,
            "Foundation": 2
        },
        "nutrients": {}
    }
}
""".data(using: .utf8)!
