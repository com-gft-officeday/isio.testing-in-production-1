package main

import (
	"os"

	"com.gft.tsbo-training.src.go/fe-weather/feweather"
)

// ###########################################################################
// ###########################################################################
// MAIN
// ###########################################################################
// ###########################################################################

var usage []byte = []byte("fe-weather: [OPTIONS] ")

func main() {

	var ms fe-weather.FeMeasure

	fe-weather.InitFromArgs(&ms, os.Args, nil)

	ms.Run()
}
