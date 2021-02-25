require 'fileutils'
require 'json'
require 'yaml'

# TODO, pull these in from a protobuf repo
images = [
  {
    name: "elixir",
    extensions: [
      "jakebecker.elixir-ls",
      "mjmcloug.vscode-elixir"
    ],
  },
  {
    name: "erlang",
    extensions: [
      "erlang-ls.erlang-ls",
      "pgourlain.erlang",
      "yuce.erlang-otp",
      "sztheory.erlang-formatter",
      "nigelrook.vscode-linter-erlc",
      "sztheory.hex-lens"
    ]
  },
  {
    name: "flutter",
    extensions: [
      "dart-code.dart-code",
      "dart-code.flutter",
      "nash.awesome-flutter-snippets",
      "alexisvt.flutter-snippets",
      "luanpotter.dart-import",
      "naco-siren.gradle-language",
      "mathiasfrohlich.kotlin"
    ]
  },
  {
    name: "golang",
    extensions: [
      "golang.go"
    ]
  },
  {
    name: "nodejs",
    extensions: [
      "flowtype.flow-for-vscode",
      "dbaeumer.vscode-eslint",
      "naumovs.color-highlight"
    ]
  },
  {
    name: "python",
    extensions: [
      "ms-python.python"
    ]
  },
  {
    name: "terraform",
    extensions: [
      "hashicorp.terraform"
    ]
  }
]

global_extensions = [
  "coenraads.bracket-pair-colorizer-2",
  # "equinusocio.vsc-community-material-theme",
  "oderwat.indent-rainbow",
  "zainchen.json",
  "equinusocio.vsc-material-theme",
  "equinusocio.vsc-material-theme-icons"
  # googlecloudtools.cloudcode
]

gitpod_global_settings = {
  "image" => {
    "file" => ".devcontainer/gitpod.Dockerfile"
  }
}

vscode_global_settings = {
  "workbench.iconTheme": "vscode-icons",
  "materialTheme.accent": "Orange",
  "workbench.startupEditor": "readme",
  "workbench.colorTheme": "Community Material Theme High Contrast",
  "terminal.integrated.shell.linux": "/usr/bin/zsh"
}

# def merge_and_write()
# settings_hash = gitpod_global_settings.clone
#   if File.file?(file_path)
#     existing_file = YAML.load(File.read(file_path))
#     existing_file.keys.each do|key|
#       unless settings_hash.include?(key.to_sym)
#         settings_hash[key] = existing_file[key]
#       end
#     end
#   end
#   File.open(file_path, "w") { |f|
#     f.puts JSON.pretty_generate(settings_hash)
#   }
# end

images.each do|image_object|
  image = image_object[:name]

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
  file_path = "files/gitpod/#{image}/gitpod.yml.tpl"
  settings_hash = gitpod_global_settings.clone
  # settings_hash = {
  #   "name" => "foobar"
  # }
  puts settings_hash
  if File.file?(file_path)
    existing_file = YAML.load(File.read(file_path))
    existing_file.keys.each do|key|
      unless settings_hash.include?(key)
        settings_hash[key] = existing_file[key]
      end
    end
  end
  extensions = global_extensions.clone + image_object[:extensions]
  # extensions.merge!(image_object[:extensions])
  settings_hash['vscode'] = {
    'extensions' => extensions.to_a
  }
  File.open(file_path, "w") { |f|
  puts settings_hash.to_yaml
    f.write(settings_hash.to_yaml)
  }

  ####################
  #   devcontainer   #
  FileUtils.mkdir_p "files/devcontainer/#{image}"
  File.open("files/devcontainer/#{image}/Dockerfile.tpl", "w") { |f|
    f.puts "# THIS FILE IS GENERATED, EDITS WILL BE OVERWRITTEN"
    f.puts "FROM ${image_registry}/${workspace_image}:${workspace_image_tag}"
  }
  file_path = "files/devcontainer/#{image}/devcontainer.json.tpl"
  settings_hash = {
    "name": "Container Labs #{image}",
    "dockerFile": "Dockerfile",
    "extensions": global_extensions + image_object[:extensions],
    "settings": vscode_global_settings
  }
  File.open(file_path, "w") { |f|
    f.puts JSON.pretty_generate(settings_hash)
  }


  ####################
  #   vscode   #
  FileUtils.mkdir_p "files/vscode/#{image}"

  settings_hash = vscode_global_settings.clone
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
