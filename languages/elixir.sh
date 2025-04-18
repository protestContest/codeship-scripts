#!/bin/bash
# Install a custom Elixir version, http://elixir-lang.org/
#
# In most cases you'll need to also include the custom Erlang script from this
# repository (same folder) to install a suitable version of the Erlang VM.
#
# Add at least the following environment variables to your project configuration
# (otherwise the defaults below will be used).
# * ELIXIR_VERSION
#
# Include in your builds via
# source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/elixir.sh)"
OTP_VERSION=${OTP_VERSION:="25"}
ELIXIR_VERSION=${ELIXIR_VERSION:="1.2.3"}
ELIXIR_PATH=${ELIXIR_PATH:=$HOME/elixir}
CACHED_DOWNLOAD="${HOME}/cache/elixir-v${ELIXIR_VERSION}.zip"

# no set -e because this file is sourced and with the option set a failing command
# would cause an infrastructure error message on Codeship.
mkdir -p "${ELIXIR_PATH}"

ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/elixir-otp-${OTP_VERSION}.zip"

wget --continue --output-document "${CACHED_DOWNLOAD}" "${ELIXIR_DOWNLOAD_URL}"
unzip -q -o "${CACHED_DOWNLOAD}" -d "${ELIXIR_PATH}"

export PATH="${ELIXIR_PATH}/bin:${PATH}"

# check the correct version is used
elixir --version | grep "${ELIXIR_VERSION}"
