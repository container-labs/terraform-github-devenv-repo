require 'fileutils'
require 'json'

images = [
  "elixir",
  "erlang",
  "flutter",
  "nodejs",
  "terraform"
]

global_settings = {
  "workbench.iconTheme": "vscode-icons",
  "materialTheme.accent": "Orange",
  "workbench.startupEditor": "readme",
  "workbench.colorTheme": "Community Material Theme High Contrast"
}

images.each do|image|
  FileUtils.mkdir_p "gitpod-workspaces/#{image}"
  File.open("gitpod-workspaces/#{image}/Dockerfile", "w") { |f|
    f.puts "# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest"
    f.puts "FROM ${BASE_IMAGE}"
    f.puts "ARG #{image.upcase}_VERSION=default"
    f.puts ""
    f.puts "USER gitpod"
    f.puts ""
    f.puts "RUN asdf plugin add #{image}"
    f.puts "RUN asdf install #{image} ${#{image.upcase}_VERSION} && \\
      asdf global #{image} ${#{image.upcase}_VERSION}"
  }

  ##############
  #   GitPod   #
  FileUtils.mkdir_p "files/gitpod/#{image}"
  File.open("files/gitpod/#{image}/gitpod.Dockerfile.tpl", "w") { |f|
    f.puts "# THIS FILE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}:${workspace_image_tag}"
  }
  File.open("files/gitpod/#{image}/gitpod.digest.Dockerfile.tpl", "w") { |f|
    f.puts "# THIS FILE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}@${workspace_image_digest}"
  }

  ####################
  #   devcontainer   #
  FileUtils.mkdir_p "files/devcontainer/#{image}"
  File.open("files/devcontainer/#{image}/Dockerfile.tpl", "w") { |f|
    f.puts "# THIS FILE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}:${workspace_image_tag}"
  }

  ####################
  #   vscode   #
  FileUtils.mkdir_p "files/vscode/#{image}"

  settings_hash = global_settings.clone
  puts File.absolute_path("files/vscode/#{image}/settings.json.tpl")
  file_path = File.absolute_path("files/vscode/#{image}/settings.json.tpl")
  if File.file?(file_path)
    begin
      existing_file = JSON.parse(File.read(file_path))
      existing_file.keys.each do|key|
        unless settings_hash.include?(key.to_sym)
          settings_hash[key] = existing_file[key]
        end
      end
    rescue => e
      puts e
    end
  end
  # blocks procs and lamdas oh my
  File.open(file_path, "w") { |f|
    f.puts JSON.pretty_generate(settings_hash)
    # # poor mans pretty print
    # f.puts '{'
    # settings_hash.keys.slice(0, settings_hash.keys.length - 1).each do|key|
    #   f.puts "  \"#{key}\" : \"#{settings_hash[key]}\","
    # end
    # # if settings_hash.keys.length > 1
    # last_key = settings_hash.keys[-1]
    # f.puts "  \"#{last_key}\" : \"#{settings_hash[last_key]}\""
    # f.puts '}'
  }
end
