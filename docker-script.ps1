param($name="haxe")
docker -H build.swarm.devfactory.com build -t parvsharma/$name .
docker -H build.swarm.devfactory.com tag parvsharma/$name registry2.swarm.devfactory.com/parvsharma/$name
docker -H build.swarm.devfactory.com push registry2.swarm.devfactory.com/parvsharma/$name
docker pull registry2.swarm.devfactory.com/parvsharma/$name
docker tag registry2.swarm.devfactory.com/parvsharma/$name $name
docker tag $name parv0888/$name
docker-compose build
docker-compose up