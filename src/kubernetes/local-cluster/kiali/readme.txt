http://localhost:20001/kiali/console/graph/namespaces/?traffic=grpc%2CgrpcRequest%2Chttp%2ChttpRequest%2Ctcp%2CtcpSent&graphType=versionedApp&namespaces=com-gft-officeday-istio-testing-in-production&duration=60&refresh=10000&animation=true&idleEdges=true&idleNodes=true&layout=dagre

kubectl port-forward -n istio-system service/kiali 20001:20001
