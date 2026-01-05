resource "aws_key_pair" "ToDo_App" {
  key_name = "ToDo_App"
  public_key = file("../modules/KEY/ToDo_App.pub")
}