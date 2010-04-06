from random import randint
from itertools import product

def combinator(first_names, last_names, separator = " ", prefix="", sufix=""):
    return  map("".join,product([prefix], first_names, [separator], last_names, [sufix]))+\
            map("".join,product([prefix], last_names, [separator], first_names, [sufix]))

def generate_numbers(number, start=1, type="int"):
    numbers = []
    if type == "float":
        start = float(start)
    for i in range(number):
        numbers.append(start)
        start += 1
    return numbers

def generate_phones(number):
    phones = []
    for i in range(number):
        phone.append("".join(str(randint(0,9)) for x in range(8)))
    return phones

def generate_people():
    first_names = ["Joao", "Maria", "Dedeu", "Diguliu", "Michael", "Daniela", "Kratus", "Chuck", "Johnny", "Ze", "Conf", "Joca"]
    last_names = ["Silva", "Oliveira", "Alcantra", "Souto", "Jackson", "Norris", "Santos", "Neto", "Braga", "Correa", "Depp", "Jordan" ]
    
    people_names = combinator(first_names, last_names)
    people_emails = combinator(map(str.lower,first_names), map(str.lower,last_names), "@", "", ".com")
    people_addresses = combinator(first_names, last_names, " - ", "Street ")
    people_cpfs = generate_numbers(len(people_names),345746345)
    people_cpfs = map(str, people_cpfs)

    return zip(*[people_cpfs, people_names, people_addresses, people_emails])

def generate_clients(people, percent):
    clients = []
    for i in range(int(len(people)*percent)):
        login = people[i][1].lower().replace(' ','_')
        clients.append([login, people[i][0], "dfasdj"])
    return clients


def generate_bands():
    first_names = ["The", "Arctic", "Pearl", "Led", "Avenged"]
    last_names = ["Zeppelin", "Monkeys", "Sevenfold", "Jam", "Beatles"]

    band_names = combinator(first_names, last_names)
    logins = combinator(map(str.lower,first_names), map(str.lower,last_names),"_")
    passwords = generate_numbers(len(logins))
    passwords = map(str, passwords)

    first_style_names = ["Hard", "Black", "Emo", "Heavy", "Folk"]
    last_style_names = ["Metal", "Core", "Punk", "Grunge", "Rock"]
    style_names = combinator(first_style_names, last_style_names)

    return zip(*[logins, band_names, style_names, ["www.all-bands.com"]*len(logins), passwords])

def generate_equipments():
    description = ["Semi-Acoustic", "Eletric", "Acoustic", "Tuned", "Golden"]
    models = ["Les Paul", "Stratocaster", "Flying V", "SG", "Telecaster"]
    types = ["Guitar", "Bass", "Drums", "Microphone", "Amplificator"]

    equipment_types = combinator(types, models)
    equipment_ids = generate_numbers(len(equipment_types))
    internal_prices = generate_numbers(len(equipment_types),20,"float")
    external_prices = generate_numbers(len(equipment_types),50,"float")

    return zip(*[equipment_ids, ["Model"]*len(equipment_types), equipment_types, internal_prices, external_prices])

def generate_services():
    first_names = ["Record", "Sell", "Rent", "Practice", "Make"]
    last_names = ["Albuns", "Instruments", "Equipments", "Rooms", "Dvds"]

    service_names = combinator(first_names, last_names)
    service_ids = generate_numbers(len(service_names))
    prices = generate_numbers(len(service_names),30,"float")

    return zip(*[service_ids, service_names, prices, ["Description"]*len(service_names)])


def generate_insert_sql(attributes, entities, table_name):
    colums = ""
    sql_code = ""
    for attribute in attributes:
        colums += ',' + attribute
    colums = colums[1:]
    for entity in entities:
        values = ""
        for att in entity:
            if type(att).__name__ != "int" and type(att).__name__ != "float":
                att = "\'{0}\'".format(att)
            values += ',' + str(att)
        values = values[1:]
        sql_code += "INSERT INTO %(table_name)s (%(colums)s)\nVALUES (%(values)s);" % \
                {   'table_name'    : table_name,\
                    'colums'        : colums,\
                    'values'        : values}
        sql_code += "\n\n"
    return sql_code


person_attributes = ["Cpf", "Name", "Address", "Email"]
client_attributes = ["Login", "Person_Cpf", "Pass"]
band_attributes = ["Login", "Name", "Style", "HomePage", "Pass"]
equipment_attributes = ["Equipment_ID", "Model", "Equipment_Type", "InternalPrice", "ExternalPrice"]
service_attributes = ["Service_ID", "Name", "Price", "Description"]

people = generate_people()
print len(people)
clients = generate_clients(people,0.5)
print len(clients)
bands = generate_bands()
print len(bands)
equipments = generate_equipments()
print len(equipments)
services = generate_services()
print len(services)

sql_insert_code = generate_insert_sql(person_attributes, people, "Person")
sql_insert_code += generate_insert_sql(band_attributes, bands, "Band")
sql_insert_code += generate_insert_sql(equipment_attributes, equipments, "Equipment")
sql_insert_code += generate_insert_sql(service_attributes, services, "Service")
sql_insert_code += generate_insert_sql(client_attributes, clients, "Client")
file = open("testing_sql_insert_code.sql","w")
file.write(sql_insert_code)
file.close()
