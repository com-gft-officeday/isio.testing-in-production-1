package msthermometer

import (
	"com.gft.tsbo-training.src.go/common/device/implementation/devicedescriptor"
	"com.gft.tsbo-training.src.go/common/device/implementation/devicesimulation"
	"com.gft.tsbo-training.src.go/common/device/implementation/devicevalue"
	"com.gft.tsbo-training.src.go/common/ms-framework/microservice"
)

// ###########################################################################
// ###########################################################################
// MsMeasure Response - Device
// ###########################################################################
// ###########################################################################

// DeviceResponse Encapsulates the reploy of ms-thermometer
type DeviceResponse struct {
	microservice.Response
	devicedescriptor.DeviceDescriptor
	devicesimulation.DeviceSimulation
	URLDevice  string `json:"urlDevice"`
	URLMeasure string `json:"urlMeasure"`
	URLStatus  string `json:"urlStatus"`
}

// ###########################################################################

// InitDeviceResponse Constructor of a response of ms-thermometer
func InitDeviceResponse(r *DeviceResponse, status string, ms *MsMeasure) {
	microservice.InitResponseFromMicroService(&r.Response, ms, status)
	devicedescriptor.InitFromDeviceDescriptor(&r.DeviceDescriptor, &ms.DeviceDescriptor)
	devicesimulation.InitFromDeviceSimulation(&r.DeviceSimulation, &ms.DeviceSimulation)
	r.URLDevice = ms.GetEndpoint("device")
	r.URLMeasure = ms.GetEndpoint("measure")
	r.URLStatus = ms.GetEndpoint("status")
}

// NewDeviceResponse ...
func NewDeviceResponse(status string, ms *MsMeasure) *DeviceResponse {
	var r DeviceResponse
	InitDeviceResponse(&r, status, ms)
	return &r
}

// ###########################################################################
// ###########################################################################
// MsMeasure Response - Measure
// ###########################################################################
// ###########################################################################

// MeasureResponse Encapsulates the reploy of ms-thermometer
type MeasureResponse struct {
	microservice.Response
	devicedescriptor.DeviceDescriptor
	devicevalue.DeviceValue
	RnrSvcVersion string `json:"rnrSvcVersion"`
	RnrSvcName    string `json:"rnrSvcName"`
}

// ###########################################################################

// InitMeasureResponse Constructor of a response of ms-thermometer
func InitMeasureResponse(r *MeasureResponse, status string, ms *MsMeasure) {
	microservice.InitResponseFromMicroService(&r.Response, ms, status)
	devicedescriptor.InitFromDeviceDescriptor(&r.DeviceDescriptor, &ms.Device)
	// devicedescriptor.CopyDeviceDescriptor(&r.DeviceDescriptor, &ms.Device)
	ms.FillDeviceValue(&r.DeviceValue)
	r.RnrSvcVersion = "???"
	r.RnrSvcName = "???"
}

// NewMeasureResponse ...
func NewMeasureResponse(status string, ms *MsMeasure) *MeasureResponse {
	var r MeasureResponse
	InitMeasureResponse(&r, status, ms)
	return &r
}
