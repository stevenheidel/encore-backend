env = Rails.env.to_s

case env
  when 'development'
    host = 'http://b15950f4a450be307056-42f949fb9ecc6f4f732d823be32cacce.r54.cf1.rackcdn.com'
  when 'test'
    host = 'http://7bbbc84612e3b70e99f5-5e63ea74d44e2604920c3c683eddd98d.r93.cf1.rackcdn.com'
  when 'staging'
    host = 'http://1160a4fe6acb5dc1a55d-d9f503ebf2151b8ec0897b25d55aa4fc.r0.cf1.rackcdn.com'
  when 'production'
    host = 'http://269664eb6fd1e0c48321-4b9cb53437516fb358c828634151de22.r34.cf2.rackcdn.com'
end

directory = 'encoretheapp-' + env

Paperclip::Attachment.default_options.update(
    storage: :fog,
    fog_credentials: {
      provider: 'Rackspace',
      rackspace_username: 'NicholasKlimchuk',
      rackspace_api_key: '92acc8c9d2ecb0adb67dd6214355ad34'
    },
    fog_directory: directory,
    fog_host: host
  )