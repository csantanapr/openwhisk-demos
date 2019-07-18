FROM ibmfunctions/action-python-v3.7:1.9.0

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip setuptools six && pip install --no-cache-dir -r requirements.txt