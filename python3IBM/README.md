# New Python 3 runtime for IBM Cloud Functions

## Simplifying the use of IBM services and data science

IBM Cloud Functions sets a limit of 48 MB for your action code including dependencies, which can be large, which means you wouldn't be able to upload certain actions (if too large) or the upload would take very long, specifically when you update often. To relief you from that burden, we preinstalled several important packages.

The new runtime includes packages that are useful when integrating with IBM Cloud services such as DB2, Watson, Cloudant, and Cloud Object Storage.

In addition, some popular Python packages for data science are also pre-installed such as numpy, pandas, scipy, and scikit-learn.

The version of Python is 3.6 and is based on a Debian/Ubuntu (Jessie release) operating system. 

If you have your own python modules, or 3rd party packages you can always package them using the [virtualenv approach](https://console.bluemix.net/docs/openwhisk/openwhisk_actions.html#openwhisk_actions_python_virtualenv) and uploading a zip. In the case the the zip is too large you can [extend the runtime](https://console.bluemix.net/docs/openwhisk/openwhisk_actions.html#large-app-support) and install more additional python packages, or add system utilities and libraries using apt-get. 


For more details on the Python 3 environment, check the [documentation](https://console.stage1.bluemix.net/docs/openwhisk/openwhisk_reference.html#openwhisk_ref_python_environments)

## Using IBM Cloud Services from Python 3 Functions
 
Let's build an application that handles customer feedback that is composed with two actions in a sequence. The first one takes the text from a customer feedback form, and translates it with the IBM Watson Language service. The second action stores the content in a database by using the IBM DB2 on Cloud service.

### Watson: Translate Action using Python 3

Create a Python file "translateForm.py" with the following code:
```python
from watson_developer_cloud import LanguageTranslatorV2

def main(args):
    customer_id = args["customer_id"]
    text = args["payload"]
    language_translator = LanguageTranslatorV2(
        url=args["__bx_creds"]["language_translator"]["url"],
        username=args["__bx_creds"]["language_translator"]["username"],
        password=args["__bx_creds"]["language_translator"]["password"])
    lang_id = language_translator.identify(text)["languages"][0]["language"]
    response = language_translator.translate(text, source=lang_id, target='en')
    return {"payload": response["translations"][0]["translation"],
            "customer_id": customer_id}
```

### DB2: Store Action using Python 3

Create a Python file "storeFormDB.py" with the following code:
```python
import ibm_db
import datetime

def main(args):
    global conn
    customer_id = args["customer_id"]
    text = args["payload"]
    ssldsn = args["__bx_creds"]["dashDB"]["ssldsn"]
    if globals().get("conn") is None:
        conn = ibm_db.connect(ssldsn, "", "")
    statement = "INSERT INTO CUSTOMER_FEEDBACK (CUST_ID, FEEDBACK, date) VALUES (?, ?, ?)"
    stmt = ibm_db.prepare(conn, statement)
    ts_val = datetime.datetime.today()
    result = ibm_db.execute(stmt,(customer_id, text, ts_val))
    return {"result": f"Stored feedback {text} from customer {customer_id} at {ts_val}"}
```
Tip: The Action assumes that a DB table `CUSTOMER_FEEDBACK` is already created and available.

### Sequence: Deploy the Actions

Deploy your actions that use the kind `python-jessie:3` to use the new Python 3 runtime:
```       
bx wsk action create translateForm translateForm.py --kind  python-jessie:3
```
``` 
bx wsk action create storeFormDB   storeFormDB.py   --kind  python-jessie:3
```
``` 
bx wsk action create myCustomerFormSeq translateForm,storeFormDB --sequence
```

### Set up the credentials for the Actions

Bind the service credentials to the actions parameters.

You can use the IBM Cloud Functions CLI to bind your actions to IBM Cloud Services*.

Bind the action `translateForm` to the `language_translator` service credentials:
```
bx wsk service bind language_translator translateForm
```
Bind the action `storeFormDB` to the `dashDB` service credentials:
```
bx wsk service bind dashDB storeFormDB
```
Tip: You must have at least one set of Credentials for the service before running the `bx wsk service bind` command.

This CLI command copied the service credentials and set them as default action parameter, by convention a single parameter of type JSON object named `__bx_creds`. 

You can also do this directly by setting the default parameters with the values from your service credentials into any parameter, and then adjust your action code appropriately.

*Note: Cloud Object Storage can't be bound to actions using the CLI but support will be added soon. This blog post will be updated when support is available.

### Test your Customer Feedback Application

You can now test your application by invoking your sequence action like this:
```
bx wsk action invoke myCustomerFormSeq \
-p customer_id 42 \
-p payload "Muy buen servicio" -r
```
```json
{
    "result": "Stored feedback Very good service from customer ..."
}
```

### Python and Data Science

Python is probably the programming language of choice for data scientists for prototyping, visualization, and running data analyses on data sets.
There are many libraries, applications and techniques to analyze data in Python.

The new runtime includes a few libraries that you can leverage from you Actions. Here is an example using [Pandas](https://pandas.pydata.org/) and [Numpy](http://www.numpy.org/):
```python
import pandas as pd
import numpy as np

def main(args):
    dates = pd.date_range('20130101', periods=2)
    df = pd.DataFrame(np.random.randn(2,2), index=dates, columns=list('AB'))
    print(df)
    return df.to_dict('split')
```
### Deploy your data science action
```
bx wsk action update pandas pandas.py --kind python-jessie:3
```
### Invoke your data science action
```
bx wsk action invoke pandas -r
```
```json
{
    "columns": [
        "A",
        "B"
    ],
    "data": [
        [
            -1.2921755448830252,
            0.5663123130894548
        ],
        [
            1.0437128172227568,
            1.0506338576086816
        ]
    ],
    "index": [
        "Tue, 01 Jan 2013 00:00:00 GMT",
        "Wed, 02 Jan 2013 00:00:00 GMT"
    ]
}
```
