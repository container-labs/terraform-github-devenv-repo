require 'fileutils'

images = [
  "elixir",
  "erlang",
  "flutter",
  "nodejs",
  "terraform"
]

images.each do|image|
  # FileUtils.mkdir_p "gitpod-workspaces/#{image}"
  # File.open("gitpod-workspaces/#{image}/Dockerfile", "w") { |f|
  #   f.puts "# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN"
  #   f.puts "ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest"
  #   f.puts "FROM ${BASE_IMAGE}"
  #   f.puts "ARG #{image.upcase}_VERSION=default"
  #   f.puts ""
  #   f.puts "USER gitpod"
  #   f.puts ""
  #   f.puts "RUN asdf plugin add #{image}"
  #   f.puts "RUN asdf install #{image} ${#{image.upcase}_VERSION} && \\
  #     asdf global #{image} ${#{image.upcase}_VERSION}"
  # }

  FileUtils.mkdir_p "files/gitpod/#{image}"
  File.open("files/gitpod/#{image}/gitpod.Dockerfile.tpl", "w") { |f|
    f.puts "# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}:${workspace_image_tag}"
  }
  File.open("files/gitpod/#{image}/gitpod.digest.Dockerfile.tpl", "w") { |f|
    f.puts "# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}@${workspace_image_digest}"
  }

  FileUtils.mkdir_p "files/devcontainer/#{image}"
  File.open("files/devcontainer/#{image}/Dockerfile.tpl", "w") { |f|
    f.puts "# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}:${workspace_image_tag}"
  }
end









# create directories
