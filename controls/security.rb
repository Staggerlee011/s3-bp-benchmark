title 'S3 - Best Practice - Configuration'

control 'exist' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'should exist'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should exist }
  end
end

control 'not_public' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'The S3 bucket should not be public'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should_not be_public }
  end
end

control 'versioning' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should have_versioning_enabled }
  end
end

control 'default_encryption' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should have_default_encryption_enabled }
	end
end

control 'access_logging' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should have_access_logging_enabled }
  end
end

control 'secure_transport' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should have_secure_transport_enabled }
  end
end