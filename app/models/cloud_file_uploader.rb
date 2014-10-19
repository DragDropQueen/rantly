class CloudFileUploader
  def self.create_presigned_s3_object
    post_options = {key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read}

    S3_BUCKET.presigned_post(post_options)
  end
end