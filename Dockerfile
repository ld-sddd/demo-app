# Use an official Python runtime as a base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY app/app.py .

# Expose the Flask port (default 5000)
EXPOSE 5000

# Define the entry point to run the Flask app
CMD ["python", "app.py"]
