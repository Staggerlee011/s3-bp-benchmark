INSPEC_CMD=docker run -e CHEF_LICENSE=accept-silent -e AWS_REGION -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN --rm -v$(PWD):/share chef/inspec:4
INSPEC_TOOLS_CMD=docker run -e CHEF_LICENSE=accept-silent --rm -v$(PWD):/share mitre/inspec_tools

CKL_FILENAME=AWS_S3_1.0_BENCHMARK

BENCHMARK_INPUT_FILE ?= inputs.yml

all: benchmark checklist

benchmark: $(CKL_FILENAME).xml

checklist: $(CKL_FILENAME).ckl

.PHONY: all benchmark checklist

$(CKL_FILENAME).xml: attributes.yml $(CKL_FILENAME).json
	$(INSPEC_TOOLS_CMD) inspec2xccdf -j $(CKL_FILENAME).json -a attributes.yml -o $(CKL_FILENAME).xml

$(CKL_FILENAME).ckl: attributes.yml $(CKL_FILENAME).json
	$(INSPEC_TOOLS_CMD) inspec2ckl -j $(CKL_FILENAME).json -m metadata-ckl.json -o $(CKL_FILENAME).ckl

$(CKL_FILENAME).json: inspec.yml controls/*.rb
	$(INSPEC_CMD) exec . -t aws:// --input-file $(BENCHMARK_INPUT_FILE) --reporter cli json:$(CKL_FILENAME).json

clean:
	rm -rf $(CKL_FILENAME).ckl $(CKL_FILENAME).json $(CKL_FILENAME).xml
