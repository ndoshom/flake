
{pkgs}: let
  addService = pkgs.writeShellScriptBin "addservice" ''
    #!/bin/sh
    set -e

    # Check if fzf is installed
    if ! command -v fzf >/dev/null 2>&1; then
      echo "Error: fzf is not installed. Please install it first."
      exit 1
    fi

    # Check if /etc/sv exists
    if [ ! -d "/etc/sv" ]; then
      echo "Error: /etc/sv directory does not exist."
      exit 1
    fi

    # Create /var/service if it doesn't exist
    if [ ! -d "/var/service" ]; then
      sudo mkdir -p /var/service
      echo "Created /var/service directory."
    fi

    # List available services in /etc/sv using fzf
    selected=$(ls -1 /etc/sv | ${pkgs.fzf}/bin/fzf --multi --prompt="Select services to add to /var/service: ")

    # Check if user made a selection
    if [ -z "$selected" ]; then
      echo "No services selected. Exiting."
      exit 0
    fi

    # Add selected services to /var/service
    while IFS= read -r service; do
      if [ -d "/etc/sv/$service" ]; then
        if [ -L "/var/service/$service" ]; then
          echo "Service $service already exists in /var/service."
        else
          sudo ln -s "/etc/sv/$service" /var/service/
          echo "Added $service to /var/service."
        fi
      else
        echo "Error: $service is not a valid service directory in /etc/sv."
      fi
    done <<< "$selected"

    echo "Done."
  '';
in {
    inherit addService;
  }
