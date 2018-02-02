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
    if not result:
        return {"err": "error :" + statement}
    return {"result": f"stored feed back {text} from customer {customer_id} at {ts_val}"}
