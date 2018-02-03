import ibm_db
import datetime


def main(args):
    global conn
    ssldsn = args["__bx_creds"]["dashDB"]["ssldsn"]
    if globals().get("conn") is None:
        print("creating connection")
        conn = ibm_db.connect(ssldsn, "", "")
    else:
        print("reusing connection")
    drop = "DROP TABLE CUSTOMER_FEEDBACK"
    result = ''
    try:
        result = ibm_db.exec_immediate(conn, drop)
    except:
        pass
    statement = "CREATE TABLE CUSTOMER_FEEDBACK (CUST_ID INTEGER, FEEDBACK VARCHAR(255), date TIMESTAMP)"
    result = ibm_db.exec_immediate(conn, statement)
    # Check table creation
    statement = "SELECT * FROM CUSTOMER_FEEDBACK"
    result = ibm_db.exec_immediate(conn, statement)
    for i in range(0, ibm_db.num_fields(result)):
        print(str(i), ":", ibm_db.field_type(result, i))
    ts_val = datetime.datetime.today()
    print("the time is", ts_val)
    # Try to insert sample test row
    statement = "INSERT INTO CUSTOMER_FEEDBACK (CUST_ID, FEEDBACK, date) VALUES (?, ?, ?)"
    stmt = ibm_db.prepare(conn, statement)
    result = ibm_db.execute(stmt, (10001, "IBM Functions Rocks!", ts_val))
    statement = "SELECT * FROM CUSTOMER_FEEDBACK"
    stmt = ibm_db.prepare(conn, statement)
    rc = ibm_db.execute(stmt)
    result = ibm_db.fetch_row(stmt)
    print(ibm_db.result(stmt, 0), ibm_db.result(
        stmt, 1), ibm_db.result(stmt, 2))
    if not result:
        return {"err": "error :" + statement}
    return {"result": "succesfully created TABLE CUSTOMER_FEEDBACK"}
