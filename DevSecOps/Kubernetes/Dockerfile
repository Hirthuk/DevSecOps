#DockerFile
FROM python:3.8

#Set the working directory
WORKDIR /app

#Copy the requirements.txt file
COPY requirements.txt .

#Install Dependencies
RUN pip install -r requirements.txt

#COPY the all the file code inside the app directory
COPY . .

#command to run the application
CMD ["python","app.py"]