# NewRelic Sysmond

To run:

```
docker run -ti \
    --rm \
    --pid=host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net=host \
    --privileged \
    -e LICENSE_KEY=<LICENSE_KEY> \
    ehazlett/newrelic-sysmond
```
