require "sshkit"
require "sshkit/dsl"
require "yaml"
include SSHKit::DSL

config = YAML.load_file "./test/config.yaml"
sshkit_config, ssh_options, host, dirs = config.values_at(*config.keys)

# Basic config:
SSHKit.config.output_verbosity = sshkit_config["output_verbosity"]
SSHKit.config.format = sshkit_config["format"]
SSHKit::Backend::Netssh.configure do |ssh|
  ssh.ssh_options = {
    user: ssh_options["user"],
  }
end

# main task list:
namespace :app do
  # build & serve:
  desc "Upload to editor."
  task :upload do
    remote = dirs["remote"]
    on host do |hst|
      within remote do
        execute :ls, "-alh"
      end
    end
  end
end
