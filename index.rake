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
  task :pack, [:version, :dist] do |task, args|
    args.with_defaults(
      version: pkg["version"],
      dist: "dist",
    )
    dist = args[:dist]
    sh "rm -rf *.tar.gz"
    sh "tar zcf #{dist}-#{args[:version]}.tar.gz #{dist}"
  end

  desc "Sync iconfonts."
  task :icons, [:url, :filename] do |task, args|
    sh "rm -rf node_modules/finxos-icons-editor-frontend"
    sh "npm install"
  end
end
