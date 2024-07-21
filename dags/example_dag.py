from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.sensors.time_sensor import TimeDeltaSensor

def print_hello():
    return 'Hello from Airflow!'

def print_date():
    return f'Current date: {datetime.now()}'

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 7, 20),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': datetime.time(hours=9,minutes=5)
}]

dag = DAG('example_dag', default_args=default_args, description='A simple example DAG', schedule_interval='0 9 * * *', catchup=True)

t0 = TimeDeltaSensor(
    task_id='wait_a_second',
    delta=timedelta(seconds=1),
    dag=dag)

t1 = PythonOperator(
    task_id='print_hello',
    python_callable=print_hello,
    dag=dag
)

t2 = PythonOperator(
    task_id='print_date',
    python_callable=print_date,
    dag=dag
)

t0 >> t1 >> t2
