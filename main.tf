resource "aws_cloudwatch_event_rule" "default" {
  name                = "${var.name}"
  schedule_expression = "${var.schedule}"
}

resource "aws_cloudwatch_event_target" "default" {
  arn       = "${var.queue_arn}"
  rule      = "${aws_cloudwatch_event_rule.default.name}"
  target_id = "${var.name}"
}

module "queue_policy" {
  source = "git::ssh://git@bitbucket.org/myvizir/terraform-sqs-queue-policy.git?ref=5d68783a4ee43d367d4bea909e220a8b2d5a1396"

  condition_values = ["${aws_cloudwatch_event_rule.default.arn}"]
  queue_url        = "${var.queue_url}"
  resources        = ["${var.queue_arn}"]
}
