# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.0/agent-keepalive_0.3.0_darwin_arm64.tar.gz"
      sha256 "44a95d67a53995cd67d0c8b3e0849a00269a412065e8b6581ab1ffca31d1ad8d"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.0/agent-keepalive_0.3.0_darwin_amd64.tar.gz"
      sha256 "36c17362623e58ad3fd58a1167f35eea071ccd6b524f9c39729ef046384a5949"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.0/agent-keepalive_0.3.0_linux_arm64.tar.gz"
      sha256 "e924a8bf72d35b14248e9fd2edb50c652dd9799224a0a48bc21f1dafba4c35d2"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.0/agent-keepalive_0.3.0_linux_amd64.tar.gz"
      sha256 "f25132e956ab0f5e3f2dcda228ba2b3a6d5b37ea0adfcbedf5d88037bb6e7e1f"
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
