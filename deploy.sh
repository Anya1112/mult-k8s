docker build -t anya1112/multi-client:latest -t anya1112/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anya1112/multi-server:latest -t anya1112/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anya1112/multi-worker:latest -t anya1112/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anya1112/multi-client:latest
docker push anya1112/multi-server:latest
docker push anya1112/multi-worker:latest
docker push anya1112/multi-client:$SHA
docker push anya1112/multi-server:$SHA
docker push anya1112/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anya1112/multi-server:$SHA
kubectl set image deployments/client-deployment client=anya1112/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anya1112/multi-worker:$SHA