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
  if input('s3_public')
    describe aws_s3_bucket(bucket_name: input('s3_name')) do
        it { should_not be_public }
    end
  else
    describe "This requirement is skipped at the choice of the user." do
      skip "This requirement is skipped at the choice of the user."
    end
  end
end

control 'versioning' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  if input('s3_versioning')
    describe aws_s3_bucket(bucket_name: input('s3_name')) do
        it { should have_versioning_enabled }
    end
  else
    describe 'This bucket does not require versioning' do
	    skip 'This bucket does not require versioning'
    end
  end
end

control 'default_encryption' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  if input('s3_default_encryption')
    describe aws_s3_bucket(bucket_name: input('s3_name')) do
        it { should have_default_encryption_enabled }
	  end
  else
    describe 'This bucket does not require default encryption' do
	    skip 'This bucket does not require default encryption'
    end
  end
end

control 'access_logging' do
  impact 0.5
  tag nist: ['CM-6']
  tag severity: 'medium'
  title 'enabled'
  if input('s3_access_logging')
    describe aws_s3_bucket(bucket_name: input('s3_name')) do
        it { should have_access_logging_enabled }
    end
  else
    describe 'This bucket does not require access logging' do
        skip 'This bucket does not require access logging'
     end
  end
end
