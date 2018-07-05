PREFIX=cfndsl
ENV=dev
ARTIFACTS_BUCKET=aws-auckland-meetup # Your artifacts bucket name

default: deploy

test:
	rubocop

cfndsl: test
	cfndsl -b infra.rb -p -o output/output.json

validate: cfndsl
	aws cloudformation validate-template --template-body file://output/output.json

package: validate
	aws cloudformation package --template-file output/output.json --s3-bucket $(ARTIFACTS_BUCKET) --output-template-file output/output.yaml

deploy: package
	aws cloudformation deploy --stack-name $(PREFIX)-$(ENV) --s3-bucket $(ARTIFACTS_BUCKET) --parameter-overrides prefix=$(PREFIX) env=$(ENV) --template-file output/output.yaml --capabilities CAPABILITY_NAMED_IAM

