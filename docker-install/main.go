package main

import (
	"flag"
	"io/ioutil"
	"log"
	"net/http"
	"path/filepath"
)

var (
	baseDir    string
	listenAddr string
)

func init() {
	flag.StringVar(&baseDir, "base-dir", "scripts", "base script directory")
	flag.StringVar(&listenAddr, "listen", ":8080", "listen address")
}

func loadScript(name string) (string, error) {
	filename := filepath.Join(baseDir, name)
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		return "", err
	}

	return string(data), nil
}

func docker(w http.ResponseWriter, r *http.Request) {
	response(w, "docker-install.sh")
}

func dockerOld(w http.ResponseWriter, r *http.Request) {
	response(w, "docker-install-old.sh")
}

func orca(w http.ResponseWriter, r *http.Request) {
	response(w, "orca-install.sh")
}

func machine(w http.ResponseWriter, r *http.Request) {
	response(w, "machine-install.sh")
}

func response(w http.ResponseWriter, scriptName string) {
	script, err := loadScript(scriptName)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-type", "text/plain")
	w.Write([]byte(script))
}

func main() {
	flag.Parse()
	http.HandleFunc("/", docker)
	http.HandleFunc("/docker-old", dockerOld)
	http.HandleFunc("/orca", orca)
	http.HandleFunc("/machine", machine)
	if err := http.ListenAndServe(listenAddr, nil); err != nil {
		log.Fatal(err)
	}
}
