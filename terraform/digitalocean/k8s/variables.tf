variable "do_token" {
  description = "Your digital ocean API token"

  // This must be placed into a secrets manager



  type = string
  default = "I need secrets manager"
}

variable "do_region" {
  description = "The digital ocean region you'd like to deploy the cluster in"
  type = string
  default = "sgp1"
  
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type = string
  default = "ASHERL-SEA-K8S-DEV"
}

variable "cluster_version" {
  description = "The version of Kubernetes to install in the cluster"
  default = "1.21.9"
}

variable "cluster_tags" {
  description = "A list of optional tags to add to the cluster"


  default     = ["a", "b", "c"]
}

variable "cluster_default_node_size" {
  description = "The size of the droplets in the default node pool in the cluster"
}

variable "cluster_default_node_count" {
  description = "The number of nodes in the default node pool in the cluster"
}

variable "cluster_default_node_tags" {
  description = "Specific tags for the node pool in the cluster - the tags from the cluster are also applied automatically"
  default     = []
}

variable "kubeconfig_path" {
  description = "The path to save the kubeconfig to"
  default     = "~/.kube/config"
}