require "json"
pkg = JSON.load File.open "./package.json"

# main task list:
namespace :app do
  desc "Create view"
  task :view do |task, args|
    sh "yo react-app:view"
  end

  desc "Create service"
  task :service do |task, args|
    sh "yo react-app:service"
  end

  desc "Create mixin"
  task :mixin do |task, args|
    sh "yo react-app:mixin"
  end
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

  desc "Sync latest iconfonts."
  task :icons do |task, args|
    sh "rm -rf node_modules/finxos-icons-editor-frontend"
    sh "npm install"
  end
end
