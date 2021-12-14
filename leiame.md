
docker build -t kedro-spark-delta .

docker run --rm --gpus all --name spark-delta-test -dit -p 4141:4141 -p 8888:8888 -p 5000:5000 -p 8008:8008 -v $(pwd):/usr/src/code/ kedro-spark-delta



docker run --rm --name spark-delta-test -dit -p 4141:4141 -p 8888:8888 -p 5000:5000 -p 8008:8008 -v $(pwd):/usr/src/code/ kedro-spark-delta



docker run --rm --name spark-delta-test -dit -p 4140:4141 -p 8887:8888 -p 5001:5000 -p 8007:8008 -v $(pwd):/usr/src/code/ kedro-spark-delta
