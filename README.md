# Airflow Starter Example

This project demonstrates a simple Apache Airflow setup with an example DAG (Directed Acyclic Graph). It's designed to help you get started with Airflow and understand the basics of creating and running workflows.

## Project Structure

```
airflow-starter-example/
├── dags/
│   └── example_dag.py
├── README.md
└── requirements.txt
```

## Prerequisites

- Python 3.10
- pip
- pyenv



## Running Airflow

1. Start the Airflow webserver:
   ```
   make run-webserver
   ```

2. In a new terminal, start the Airflow scheduler:
   ```
   make run-scheduler
   ```

3. Access the Airflow web interface by navigating to `http://localhost:8080` in your web browser.

## Example DAG

The `example_dag.py` file in the `dags/` directory contains a simple DAG with three tasks:

1. `wait_a_second`: A TimeDeltaSensor that waits for one second.
2. `print_hello`: A PythonOperator that prints "Hello from Airflow!".
3. `print_date`: A PythonOperator that prints the current date and time.

The DAG is scheduled to run daily at 9:00 AM.

## Customizing the DAG

Feel free to modify the `example_dag.py` file to experiment with different Airflow operators, sensors, and scheduling options. You can add new tasks, change the scheduling interval, or introduce more complex workflow logic.

## Troubleshooting

If you encounter any issues:

1. In the terminal cleanup the environment:
   ```
   make clean
   ```
   and then run the running airflow steps mentioned above
2. Check the Airflow logs for any error messages.
