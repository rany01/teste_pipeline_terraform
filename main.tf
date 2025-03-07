/*data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"

    tags = {
      Name        = "HelloWorld"
      Env         = "develop"
      Plataforma  = data.aws_ami.ubuntu.platform_details
    }
}

esses blocos de código não são necessários para a execução do projeto,
pois são apenas exemplos de como criar uma instância EC2 com uma imagem do Ubuntu.
Para executar o projeto, basta manter os arquivos variables.tf, outputs.tf, kubernetes.tf e eks.tf.

*/