variable "region" {
    type = string
    default = "us-east-1"
}

/*variable "Iam_users" {
    type = list
    default = ["anita","rojina","bibek","shiva"]
}*/


variable "create_instance" {
    type = bool
    default = true
}

variable "instance_count" {
    type = number
    default = 1
}

/*variable "sg_name" {
    type = string
}
*/