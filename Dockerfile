FROM python:3.7-slim


RUN apt-get -y update \
    && apt-get install -y g++ \
    && apt-get install -qq wget \
    ### Remove temporary download file
    && rm -rf /var/lib/apt/lists/*

# get packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Enable unbuffered logging
ENV PYTHONUNBUFFERED=1
# Enable Profiler
ENV ENABLE_PROFILER=1

###Create working directory for image
WORKDIR /email_server

# Grab packages from builder ###???????????#####

# Copy files in image
COPY . .

### Expose port and run server file
EXPOSE 8080
ENTRYPOINT [ "python", "email_server.py" ]
