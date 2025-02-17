FROM python:latest

# Create a group and user
RUN addgroup --gid 10001 app
RUN adduser --gid 10001 --uid 10001 \
    --home /app --shell /sbin/nologin \
    --disabled-password app

# Create necessary directories
RUN mkdir -p /app/statics/
ADD statics /app/statics/

# Copy the application
COPY app/main.py /app/main.py

# Set the user
USER app

# Set working directory
WORKDIR /app

# Expose the port
EXPOSE 8080

# Run the application
ENTRYPOINT ["python", "/app/Test.py"]
