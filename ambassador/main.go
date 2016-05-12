package main

import (
	"crypto/tls"
	"crypto/x509"
	"flag"
	"io"
	"io/ioutil"
	"net"
	"net/http"
	"net/url"

	log "github.com/Sirupsen/logrus"
)

var (
	flUpstreamSocket     string
	flListenAddr         string
	flCaPath             string
	flCertPath           string
	flKeyPath            string
	flDebug              bool
	flInsecureSkipVerify bool
)

func init() {
	flag.StringVar(&flUpstreamSocket, "u", "", "tcp addr / path to socket")
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

	if flUpstreamSocket == "" {
		log.Fatal("you must specify an upstream")
	}

	log.Infof("ambassador listening: addr=%s", flListenAddr)
	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		u, err := url.Parse(flUpstreamSocket)
		if err != nil {
			log.Error(err)
			return
		}

		host := u.Host
		// set host to path if using socket
		if host == "" {
			host = u.Path
		}

		log.Debugf("scheme=%s host=%s path=%s", u.Scheme, u.Host, u.Path)

		var c net.Conn

		cl, err := net.Dial(u.Scheme, host)
		if err != nil {
			log.Errorf("error connecting to backend: %s", err)
			return
		}

		c = cl
		hj, ok := w.(http.Hijacker)
		if !ok {
			http.Error(w, "hijack error", 500)
			return
		}

		nc, _, err := hj.Hijack()
		if err != nil {
			log.Printf("hijack error: %v", err)
			return
		}
		defer nc.Close()
		defer c.Close()

		err = r.Write(c)
		if err != nil {
			log.Printf("error copying request to target: %v", err)
			return
		}

		errc := make(chan error, 2)
		cp := func(dst io.Writer, src io.Reader) {
			_, err := io.Copy(dst, src)
			errc <- err
		}
		go cp(c, nc)
		go cp(nc, c)
		<-errc
	})

	if flCertPath != "" && flKeyPath != "" {
		log.Infof("Configuring TLS: ca=%s cert=%s key=%s", flCaPath, flCertPath, flKeyPath)
		caCert, err := ioutil.ReadFile(flCaPath)
		if err != nil {
			log.Fatal(err)
			return
		}
		caCertPool := x509.NewCertPool()
		caCertPool.AppendCertsFromPEM(caCert)

		server := &http.Server{
			Addr:    flListenAddr,
			Handler: handler,
			TLSConfig: &tls.Config{
				// ListenAndServeTLS will wire up the cert/key pairs automatically
				ClientAuth: tls.RequireAndVerifyClientCert,
				ClientCAs:  caCertPool,
			},
		}

		log.Fatal(server.ListenAndServeTLS(flCertPath, flKeyPath))
	} else {

		log.Fatal(http.ListenAndServe(flListenAddr, handler))
	}
}
