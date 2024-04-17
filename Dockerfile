# Use the official Python image from Docker Hub with Python 3.11.6
FROM python:3.11.6

# Set the working directory in the container
WORKDIR /EasyChef-BE

# Copy the current directory contents into the container at /EasyChef-BE
COPY . /EasyChef-BE

# Install system dependencies required for building numpy
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3-dev \
        gfortran \
        libopenblas-dev \
        liblapack-dev \
        libatlas-base-dev \
        cmake \
        wget && \
    rm -rf /var/lib/apt/lists/*

# Install numpy first to avoid dependency conflicts
RUN pip install --no-cache-dir numpy==1.21.1

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Install any other needed dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run FastAPI application using uvicorn when the container launches
CMD ["uvicorn", "fastapi_test:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
