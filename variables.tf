/*variable "giropops-cluster" {
    description = "giropops-cluster"
    type = string
    default = "giropops-cluster"  
}
*/

variable "image_tag" {
    description = "Tag da imagem Docker"
    type = string
    default = "latest"
}