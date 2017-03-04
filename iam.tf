resource "aws_iam_policy" "administrator" {
  name        = "administrator"
  description = "administrator"
  path        = "/"
  policy      = "${file("policies/administrator.json")}"
}

resource "aws_iam_user" "terraform_administrator" {
  name = "terraform_administrator"
}

resource "aws_iam_policy_attachment" "terraform_administrator_attach" {
  name = "terraform_administrator_attach"

  users = [
    "${aws_iam_user.terraform_administrator.name}",
  ]

  policy_arn = "${aws_iam_policy.administrator.arn}"
}

resource "aws_iam_access_key" "terraform_administrator_key" {
  user = "${aws_iam_user.terraform_administrator.name}"
}
