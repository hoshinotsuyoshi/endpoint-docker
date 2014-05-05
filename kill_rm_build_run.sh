docker kill endpoint && docker rm endpoint
docker build -t hoshinotsuyoshi/endpoint . && docker run -d -p 80:80 --name endpoint --link fc2blog:fc2blog hoshinotsuyoshi/endpoint
