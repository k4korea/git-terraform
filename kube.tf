provider "kubernetes" {
  #config_context = "my-context"
  load_config_file = "false"
  #version = "1.18"
  host    = "192.168.20.200:6443"
  #config_context = "kubernetes" 
  config_path = "C:\\Users\\kim\\.kube\\config"
#  cluster_ca_certificate  = base64decode(var.cluster_ca_certificate)  
#  token   = var.token
}
