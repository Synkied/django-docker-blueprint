all: build up create_user_db collectstatic create_cache_table migrate_db import_data
all_no_cache: build_no_cache up collectstatic create_user_db create_cache_table migrate_db import_data

init:
	pip install -r requirements.txt

create_user_db:
	docker exec --user postgres {|DOCKER_CONTAINER_PREFIX|}_db /bin/sh -c "psql -tc \"SELECT 1 FROM pg_user WHERE usename = '{|DB_NAME|}'\" | grep -q 1 || (createuser {|DB_NAME|} -s && createdb -U {|DB_NAME|} {|DB_NAME|})"

create_cache_table:
	docker exec {|DOCKER_CONTAINER_PREFIX|}_web /bin/sh -c "python manage.py createcachetable" 

migrate_db:
	docker exec {|DOCKER_CONTAINER_PREFIX|}_web /bin/sh -c 'python manage.py migrate'

import_data:
	docker exec {|DOCKER_CONTAINER_PREFIX|}_web /bin/sh -c 'python manage.py add_datas all'

cov_test:
	coverage run --omit=./lib/* manage.py test

cov_report:
	coverage report

build:
	docker-compose build

build_no_cache:
	docker-compose build --no-cache

up:
	docker-compose up -d

up_no_d:
	docker-compose up

restart:
	docker-compose restart

collectstatic:
	docker exec {|DOCKER_CONTAINER_PREFIX|}_web /bin/sh -c "python manage.py compilescss" && docker exec {|DOCKER_CONTAINER_PREFIX|}_web /bin/sh -c "python manage.py collectstatic --noinput"

bash_nginx:
	docker exec -ti {|DOCKER_CONTAINER_PREFIX|}_nginx bash

bash_web:
	docker exec -ti {|DOCKER_CONTAINER_PREFIX|}_web bash

bash_db:
	docker exec -ti {|DOCKER_CONTAINER_PREFIX|}_db bash

freeze:
	pip freeze > requirements.txt