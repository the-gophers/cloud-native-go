package main

import (
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"os"
	"strconv"
	"time"
)

func main() {
	listenAddr := ":80"
	if val := os.Getenv("LISTEN_ADDR"); val != "" {
		listenAddr = val
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		// simple
		//fmt.Fprintln(w, http.StatusText(http.StatusOK))
		// helpful
		fmt.Fprintln(w, time.Now().Format(time.RFC3339))
	})
	mux.HandleFunc("/", httpHome)
	mux.HandleFunc("/wait", httpWait)
	mux.HandleFunc("/echo", httpEcho)
	mux.HandleFunc("/host", httpHost)

	log.Printf("listening on %s\n", listenAddr)
	log.Fatal(http.ListenAndServe(listenAddr, httpLog(mux)))
}

func httpLog(handler http.Handler) http.Handler {
	return http.HandlerFunc(
		func(w http.ResponseWriter, r *http.Request) {
			log.Printf("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
			handler.ServeHTTP(w, r)
		})
}

func httpHome(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello, world\n")
}

func httpWait(w http.ResponseWriter, r *http.Request) {
	ms := 1000
	if val := r.URL.Query().Get("ms"); val != "" {
		if val, err := strconv.Atoi(val); err == nil {
			ms = val
		}
	}
	w.WriteHeader(http.StatusOK)
	time.Sleep(time.Duration(ms) * time.Millisecond)
	fmt.Fprintf(w, "hello, world\n")
}

func httpEcho(w http.ResponseWriter, r *http.Request) {
	b, err := httputil.DumpRequest(r, true)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Fprintf(w, "%s\n", b)
}

func httpHost(w http.ResponseWriter, r *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Fprint(w, hostname)
}
