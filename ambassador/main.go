package main

import (
	"crypto/tls"
	"crypto/x509"
	"flag"
	"io/ioutil"
	"os"
	"os/signal"
	"syscall"

	log "github.com/Sirupsen/logrus"
)

var (
	flUpstream           string
	flListenAddr         string
	flCaPath             string
	flCertPath           string
	flKeyPath            string
	flDebug              bool
	flInsecureSkipVerify bool
)

func init() {
	flag.StringVar(&flUpstream, "u", "127.0.0.1:8080", "upstream address")
	flag.StringVar(&flListenAddr, "l", ":8080", "listen address")
	flag.StringVar(&flCaPath, "ca", "", "path to ca")
	flag.StringVar(&flCertPath, "cert", "", "path to certificate")
	flag.StringVar(&flKeyPath, "key", "", "path to certificate key")
	flag.BoolVar(&flDebug, "D", false, "enable debug logging")
	flag.BoolVar(&flInsecureSkipVerify, "i", false, "allow insecure communication")

}

func main() {
	flag.Parse()

	if flDebug {
		log.SetLevel(log.DebugLevel)
	}

	if flUpstream == "" {
		log.Fatal("you must specify an upstream")
	}

	log.Infof("ambassador listening: addr=%s", flListenAddr)

	var tlsConfig *tls.Config

	if flCertPath != "" && flKeyPath != "" {
		log.Infof("Configuring TLS: ca=%s cert=%s key=%s", flCaPath, flCertPath, flKeyPath)
		caCert, err := ioutil.ReadFile(flCaPath)
		if err != nil {
			log.Fatal(err)
			return
		}
		caCertPool := x509.NewCertPool()
		caCertPool.AppendCertsFromPEM(caCert)

		tlsConfig = &tls.Config{
			ClientAuth: tls.RequireAndVerifyClientCert,
			ClientCAs:  caCertPool,
		}
	}

	p := Proxy{Listen: flListenAddr, Upstream: flUpstream, TLSConfig: tlsConfig}

	sigs := make(chan os.Signal)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
	go func() {
		<-sigs
		if err := p.Close(); err != nil {
			log.Fatal(err.Error())
		}
	}()

	if err := p.Run(); err != nil {
		log.Fatal(err)
	}
}
