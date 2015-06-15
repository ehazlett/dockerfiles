package main

import (
	"os"
	"os/signal"
	"syscall"

	log "github.com/Sirupsen/logrus"
	"github.com/codegangsta/cli"
	"github.com/samalba/dockerclient"
)

func eventCallback(e *dockerclient.Event, ec chan error, args ...interface{}) {
	log.Println(e)
}

func waitForInterrupt() {
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, os.Interrupt, syscall.SIGTERM, syscall.SIGQUIT)
	for _ = range sigChan {
		os.Exit(0)
	}
}

func run(c *cli.Context) {
	dockerUrl := c.String("docker")
	tlsCaCert := c.String("tls-ca-cert")
	tlsCert := c.String("tls-cert")
	tlsKey := c.String("tls-key")
	allowInsecure := c.Bool("allow-insecure")

	docker, err := GetDockerClient(
		dockerUrl,
		tlsCaCert,
		tlsCert,
		tlsKey,
		allowInsecure,
	)
	if err != nil {
		log.Fatal(err)
	}

	docker.StartMonitorEvents(eventCallback, nil)

	log.Infof("Listening for Events: %s", dockerUrl)

	waitForInterrupt()
}

func main() {
	app := cli.NewApp()

	app.Name = "docker-events"
	app.Author = "@ehazlett"
	app.Email = ""
	app.Usage = "docker event debugger"
	app.Version = "0.1"
	app.Action = run
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:   "docker, d",
			Usage:  "URL to Docker",
			Value:  "unix:///var/run/docker.sock",
			EnvVar: "DOCKER_HOST",
		},
		cli.StringFlag{
			Name:  "tls-ca-cert",
			Usage: "TLS CA Certificate",
			Value: "",
		},
		cli.StringFlag{
			Name:  "tls-cert",
			Usage: "TLS Certificate",
			Value: "",
		},
		cli.StringFlag{
			Name:  "tls-key",
			Usage: "TLS Key",
			Value: "",
		},
		cli.BoolFlag{
			Name:  "allow-insecure",
			Usage: "Allow insecure communication to daemon",
		},
	}

	app.Run(os.Args)
}
