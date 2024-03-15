# k0s-singleNode
This repository was created to document my learning process of setting up a Kubernetes cluster using the smallest Kubernetes distribution, k0s. The setup process is not straightforward, but it's a rewarding learning experience.

The `k0sctl` command-line tool will be used to provision the single-node cluster. This tool requires a `k0sctl.yaml` file to provision your Kubernetes cluster.

You can initialize this file using the `k0sctl init` command. The output will be a YAML file of type `Cluster`, which enables `k0sctl` to access the remote host where you will install Kubernetes.

To customize and bootstrap the `k0sctl.yaml` file, use the following command:
`k0sctl init --k0s <username>@<IP> > k0sctl.yaml`
This command initializes a file containing a basic/general configuration file `ClusterConfig`, `Cluster`.
and this option "--k0s" will add the default cluster configration