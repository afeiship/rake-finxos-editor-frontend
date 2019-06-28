require "json"
pkg = JSON.load File.open "./package.json"

# main task list:
namespace :app do
  # build & serve:
  desc "Build app."
  task :build, [:env] do |task, args|
    args.with_defaults(
      env: "test",
    )
    sh "npm run #{args[:env]}"
  end

  desc "Package dist file."
  task :pack do |task, args|
    version = pkg["version"]
    sh "tar zcf dist-#{version}.tar.gz dist"
  end
end
