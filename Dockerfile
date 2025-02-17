# Stage 1: Install dependencies and run tests
FROM python:3.8-slim AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ app/
COPY tests/ tests/

# Run tests
RUN python -m unittest discover tests

# Stage 2: Build the final image
FROM python:3.8-slim

# Create a group and user
RUN addgroup --gid 10001 app && \
    adduser --uid 10001 --gid 10001 --home /app --shell /sbin/nologin --disabled-password app

# Set working directory
WORKDIR /app

# Copy application code from builder stage
COPY --from=builder /app/app/ app/
COPY --from=builder /app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Change ownership
RUN chown -R app:app /app

# Switch to non-root user
USER app

# Expose the port your app runs on
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["python", "app/main.py"]
