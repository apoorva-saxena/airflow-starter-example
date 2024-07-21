PYTHON_VERSION = 3.10.14
VENV_NAME = airflow-venv
PYENV_ROOT = $(shell pyenv root)
VENV_PATH = $(PYENV_ROOT)/versions/$(VENV_NAME)
PYTHON = $(VENV_PATH)/bin/python
PIP = $(VENV_PATH)/bin/pip

.PHONY: setup install init-db create-user run-webserver run-scheduler clean

run-webserver: create-user
	@echo "Running webserver..."
	AIRFLOW_HOME=$(PWD) $(PYTHON) -m airflow webserver --port 8080

run-scheduler: create-user
	@echo "Running scheduler..."
	AIRFLOW_HOME=$(PWD) $(PYTHON) -m airflow scheduler

setup: clean $(VENV_PATH)/bin/activate

$(VENV_PATH)/bin/activate: requirements.txt
	@echo "Creating virtual environment..."
	pyenv install $(PYTHON_VERSION) -s
	pyenv virtualenv $(PYTHON_VERSION) $(VENV_NAME)
	pyenv local $(VENV_NAME)
	$(PIP) install --upgrade pip setuptools
	$(PIP) install -r requirements.txt

install: setup
	@echo "Setting up environment..."
	$(PIP) install --upgrade pip setuptools
	$(PIP) install -r requirements.txt

init-db: install
	@echo "Initializing database..."
	AIRFLOW_HOME=$(PWD) $(PYTHON) -m airflow db init

create-user: init-db
	@echo "Creating admin user..."
	AIRFLOW_HOME=$(PWD) $(PYTHON) -m airflow users create \
    	--username admin \
    	--firstname Admin \
    	--lastname User \
    	--role Admin \
    	--email admin@example.com \
    	--password admin

clean:
	pyenv uninstall -f $(VENV_NAME)
	rm -f .python-version
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	rm -rf airflow.db
	rm -rf logs