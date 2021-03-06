aws cloudformation create-stack --stack-name GGEOstack --capabilities CAPABILITY_IAM --template-body file://$PWD/GGEO_fullstack.yml

docker build -t ggeo-django .
docker image tag ggeo-django jessecns/ggeo-django
docker image push jessecns/ggeo-django

export DOCKER_HOST=tcp://<your EC2 ip address>:2375
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py collectstatic
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py migrate
docker-compose -f docker-compose.yml up -d
docker-compose -f docker-compose.yml down -v --rmi all
