docker build -t abinmathayi/multi-client:latest -t abinmathayi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abinmathayi/multi-server:latest -t abinmathayi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abinmathayi/multi-worker:latest -t abinmathayi/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push abinmathayi/multi-client:latest
docker push abinmathayi/multi-server:latest
docker push abinmathayi/multi-worker:latest

docker push abinmathayi/multi-client:$SHA
docker push abinmathayi/multi-server:$SHA
docker push abinmathayi/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=abinmathayi/multi-client:$SHA
kubectl set image deployments/server-deployment server=abinmathayi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=abinmathayi/multi-worker:$SHA