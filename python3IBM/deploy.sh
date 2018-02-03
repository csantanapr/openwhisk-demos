#!/bin/bash

# Setup DB
#bx wsk action update setupDB setupDB.py -P .env.json --kind python-jessie:3
#bx wsk action update setupDB setupDB.py --kind python-jessie:3
#bx wsk action invoke setupDB -b

# Deploy actions
bx wsk action update translateForm translateForm.py --kind python-jessie:3
bx wsk action update storeFormDB storeFormDB.py --kind python-jessie:3
#bx wsk action update storeFormDB storeFormDB.py --kind python-jessie:3 -P .env.json 

# Setup credentials
bx wsk service bind language_translator translateForm
bx wsk service bind dashDB storeFormDB --instance Db2WarehouseOnCloud

# Unit test
bx wsk action invoke translateForm -p payload "Muy buen servicio" -p customer_id 101 -r
bx wsk action invoke storeFormDB -p payload "Very good service" -p customer_id 101 -r

# Create Sequence
bx wsk action update myCustomerFormSeq translateForm,storeFormDB --sequence
bx wsk action invoke myCustomerFormSeq -p payload "Muy buen servicio" -p customer_id 101 -r

 # Data Science
bx wsk action update pandas pandas.py --kind python-jessie:3
bx wsk action invoke pandas -b
bx wsk activation get --last