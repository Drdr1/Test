FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copy only necessary files
COPY requirements.txt .
COPY gunicorn-cfg.py .

# Install Python dependencies with caching
RUN pip install --no-cache-dir -r requirements.txt --cache-dir /tmp/pip-cache

# Copy the rest of the files
COPY . .

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "run:app"]
