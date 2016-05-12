package main

import (
	"crypto/tls"
	"io"
	"net"
	"sync"

	log "github.com/Sirupsen/logrus"
)

type Proxy struct {
	Listen    string
	Upstream  string
	TLSConfig *tls.Config
	listener  net.Listener
}

func (p *Proxy) Run() error {
	var err error
	if p.listener, err = net.Listen("tcp", p.Listen); err != nil {
		return err
	}

	wg := &sync.WaitGroup{}
	for {
		if conn, err := p.listener.Accept(); err == nil {
			wg.Add(1)
			go func() {
				defer wg.Done()
				p.handle(conn)
			}()
		} else {
			return nil
		}
	}
	wg.Wait()

	return nil
}

func (p *Proxy) Close() error {
	return p.listener.Close()
}

func (p *Proxy) handle(upConn net.Conn) {
	defer upConn.Close()
	log.Debugf("accepted: %s", upConn.RemoteAddr())

	var downConn net.Conn
	if p.TLSConfig != nil {
		c, err := tls.Dial("tcp", p.Upstream, p.TLSConfig)
		if err != nil {
			log.Errorf("unable to connect to %s: %s", p.Upstream, err)
			return
		}
		defer c.Close()

		downConn = c
	} else {
		c, err := net.Dial("tcp", p.Upstream)
		if err != nil {
			log.Errorf("unable to connect to %s: %s", p.Upstream, err)
			return
		}
		defer c.Close()

		downConn = c
	}

	if err := Pipe(upConn, downConn); err != nil {
		log.Errorf("pipe failed: %s", err)
	} else {
		log.Infof("disconnected: %s", upConn.RemoteAddr())
	}
}

func Pipe(a, b net.Conn) error {
	done := make(chan error, 1)

	cp := func(r, w net.Conn) {
		n, err := io.Copy(r, w)
		log.Debugf("copied %d bytes from %s to %s", n, r.RemoteAddr(), w.RemoteAddr())
		done <- err
	}

	go cp(a, b)
	go cp(b, a)
	err1 := <-done
	err2 := <-done
	if err1 != nil {
		return err1
	}
	if err2 != nil {
		return err2
	}

	return nil
}
