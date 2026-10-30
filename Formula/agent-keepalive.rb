# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.1/agent-keepalive_0.3.1_darwin_arm64.tar.gz"
      sha256 "8bfa159bd35c1633ece329f5e0b9be7e650db70285f5611f1466a7caf15fc3df"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.1/agent-keepalive_0.3.1_darwin_amd64.tar.gz"
      sha256 "52fb9b698ffc99c421276d41e0ddfe185a7141de3e17872d6f0cf934e65573f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.1/agent-keepalive_0.3.1_linux_arm64.tar.gz"
      sha256 "d64a44335fbab3593862a7585c8d881d1be2a8a0a7b5f465b032f120e3ddfe0e"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.1/agent-keepalive_0.3.1_linux_amd64.tar.gz"
      sha256 "982119c36f9e97fa75918187c058b44a829360084b5ab066a58e88c7bb6b752a"
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
