FROM python:3.9

# COPY files with a more specific directory to avoid copying unnecessary files
COPY ./requirements.txt .

# Set environment variables using the new format
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install python dependencies
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# COPY the rest of the files
COPY . .

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "run:app"]
