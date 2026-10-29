# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.2.0/agent-keepalive_0.2.0_darwin_arm64.tar.gz"
      sha256 "b4b9ed752d055dbb713e055e803928090f68add6dc9fa04bf49e3d318a77c7fd"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.2.0/agent-keepalive_0.2.0_darwin_amd64.tar.gz"
      sha256 "c56fc219618183c1aa0ad424b0e4f1f87524246a1c1166578061e0ec2b8a3c0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.2.0/agent-keepalive_0.2.0_linux_arm64.tar.gz"
      sha256 "2b20eae13dc3daf1e401686bd831107d1324840cd95794565931e64d3bb4c3c2"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.2.0/agent-keepalive_0.2.0_linux_amd64.tar.gz"
      sha256 "1ffb4fd7b6f6f545e0d0ac92de791ce91ab60431ca8e9987ec39541d3cd2cafb"
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
