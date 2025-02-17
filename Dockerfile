# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Create a group and user with specific IDs
RUN addgroup --gid 10001 app && \
    adduser --uid 10001 --gid 10001 --home /app --shell /sbin/nologin --disabled-password app

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Change ownership of the application directory
RUN chown -R app:app /app

# Switch to the non-root user
USER app

# Expose the port the application runs on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["python", "Test.py"]
