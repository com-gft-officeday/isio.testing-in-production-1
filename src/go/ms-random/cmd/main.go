package main

import (
	"os"

	"com.gft.tsbo-training.src.go/ms-random/msrandom"
)

// ###########################################################################
// ###########################################################################
// MAIN
// ###########################################################################
// ###########################################################################

var usage []byte = []byte("ms-random: [OPTIONS] ")

func main() {

	var ms msrandom.MsRandom
	msrandom.InitFromArgs(&ms, os.Args, nil)
	ms.Run()
}
