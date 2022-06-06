title 'S3 - Best Practice - Configuration'

control 'exist' do
  impact 0.5
  tag nist: ['CM-8']
  tag cci: ['CCI-000389', 'CCI-000392', 'CCI-000395', 'CCI-000398']
  tag severity: 'medium'
  title 'should exist'
  describe aws_s3_bucket(bucket_name: input('s3_name')) do
    it { should exist }
  end
end

control 'public' do
  impact 0.5
  tag nist: ['AC-6', 'AC-22']
  tag cci: ['CCI-000225', 'CCI-001476', 'CCI-001478']
  title 'not public'
  tag severity: 'low'
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
  tag nist: ['SI-12']
  tag cci: ['CCI-001315', 'CCI-001678']
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
  tag nist: ['SC-28']
  tag cci: ['CCI-001199', 'CCI-002472']
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
  tag nist: ['AU-12']
  tag cci: ['CCI-000169', 'CCI-001459', 'CCI-000171']
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
