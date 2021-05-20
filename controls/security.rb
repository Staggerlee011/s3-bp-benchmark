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

control 'public' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'not public'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    if input('s3_public')
      it { should_not be_public }
    else
      it { should be_public }
    end
  end
end

control 'versioning' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    if input('s3_versioning')
      it { should have_versioning_enabled }
    else
      it { should_not have_versioning_enabled }
    end
  end
end

control 'default_encryption' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    if input('s3_default_encryption')
      it { should have_default_encryption_enabled }
    else
      it { should_not have_default_encryption_enabled }
    end
  end
end

control 'access_logging' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    if input('s3_access_logging')
      it { should have_access_logging_enabled }
    else
      it { should_not have_access_logging_enabled }
    end
  end
end
