title 'S3 - Best Practice - Configuration'

control 'exist' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'should exist'
  describe aws_s3_bucket(bucket_name:input('s3_name')) do
    it { should exist }
  end
end

control 'public' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'not public'
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

control 'encrpyion' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should have_default_encryption_enabled }
  end
end
