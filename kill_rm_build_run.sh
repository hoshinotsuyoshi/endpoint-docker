cont=$(docker ps | grep endpoint | cut -d' ' -f1)
docker kill $cont && docker rm $cont
docker build -t hoshinotsuyoshi/endpoint . && docker run -d -p 80:80 hoshinotsuyoshi/endpoint
