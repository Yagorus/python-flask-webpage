FROM python:3.6-slim

COPY . /deploy/
COPY ./requirements.txt /deploy/requirements.txt

WORKDIR /deploy/

RUN pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python"]
CMD ["index.py"]
