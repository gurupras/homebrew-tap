# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.0/agent-keepalive_0.4.0_darwin_arm64.tar.gz"
      sha256 "af145d50fb93e88d61107e8c8d18a15ea219d1c13bd6ad2fcd23aa4454c18315"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.0/agent-keepalive_0.4.0_darwin_amd64.tar.gz"
      sha256 "b44cf9ef8afeca2bc062be9b55c9d1d324e6ab20652f82e7c259aa9865b1280d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.0/agent-keepalive_0.4.0_linux_arm64.tar.gz"
      sha256 "927099784312fe92496b88a42b50a7be0095414990021f1a2e8c059bf5732d2d"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.0/agent-keepalive_0.4.0_linux_amd64.tar.gz"
      sha256 "be0210e86492399536baacf117054e220a6402d8ce09bbd0b00562b5deb4c74e"
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
