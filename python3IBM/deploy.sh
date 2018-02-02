#!/bin/bash

#When availbel in prod
bx wsk action update translateForm translateForm.py --kind python-jessie:3
#bx wsk action update translateForm translateForm.py --docker ibmfunctions/action-python-v3
bx wsk action invoke translateForm -p payload "Muy buen servicio" -p customer_id 101 -r

#bx wsk action update storeFormDB storeFormDB.py --kind python-jessie:3
bx wsk action update storeFormDB storeFormDB.py --kind python-jessie:3 -P .env.json 
#bx wsk action update storeFormDB storeFormDB.py --docker ibmfunctions/action-python-v3
bx wsk action invoke storeFormDB -p payload "Very good service" -p customer_id 101 -r

bx wsk service bind language_translator translateForm
#bx wsk service bind dashDB storeFormDB --instance Db2WarehouseOnCloud


bx wsk action update myCustomerFormSeq translateForm,storeFormDB --sequence
bx wsk action invoke myCustomerFormSeq -p payload "Muy buen servicio" -p customer_id 101 -r

#bx wsk action update setupDB setupDB.py -P .env.json --kind python-jessie:3
#bx wsk action update setupDB setupDB.py --kind python-jessie:3
#bx wsk action invoke setupDB -b
#bx wsk action get setupDB parameters

bx wsk action update pandas pandas.py --kind python-jessie:3
bx wsk action invoke pandas -b

bx wsk activation get --last