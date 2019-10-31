docker build -t rushildayabme/multi-client:latest -t rushildayabme/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rushildayabme/multi-server:latest -t rushildayabme/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rushildayabme/multi-worker:latest -t rushildayabme/multi-worker:$SHA -f ./server/Dockerfile ./worker
docker push rushildayabme/multi-client:latest
docker push rushildayabme/multi-worker:latest
docker push rushildayabme/multi-server:latest
docker push rushildayabme/multi-client:$SHA
docker push rushildayabme/multi-worker:$SHA
docker push rushildayabme/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rushildayabme/multi-server:$SHA
kubectl set image deployments/client-deployment client=rushildayabme/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rushildayabme/multi-worker:$SHA