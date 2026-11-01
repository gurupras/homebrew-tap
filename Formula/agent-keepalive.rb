# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.3/agent-keepalive_0.4.3_darwin_arm64.tar.gz"
      sha256 "c45438b2e5300f8f1245ca1d32dc397bf9bcdc2c1ed39ea8cb9aef56381fd80c"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.3/agent-keepalive_0.4.3_darwin_amd64.tar.gz"
      sha256 "29716f339dd1714726cd1afd2782f4066fd143e445ea4ec725ee92962e740f09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.3/agent-keepalive_0.4.3_linux_arm64.tar.gz"
      sha256 "2f55155793f98ad4ef3ded3afa728ea96b445baaf28d7e07e1e45f49907c8d3b"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.3/agent-keepalive_0.4.3_linux_amd64.tar.gz"
      sha256 "f9deee0f8a28d10eaeb18a931bbd992de1ea4003357e434c5182932af62218dc"
    end
  end

  def install
    bin.install "agent-keepalive"
    # The archive's binary is linked as an "archive" install, which would
    # update itself. This file tells it that brew owns it: it then shows
    # `brew upgrade agent-keepalive` instead of updating in place.
    (libexec/"install-kind").write("brew\n")
  end

  service do
    run [opt_bin/"agent-keepalive", "serve"]
    keep_alive true
    log_path var/"log/agent-keepalive.log"
    error_log_path var/"log/agent-keepalive.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-keepalive version")
  end
end
