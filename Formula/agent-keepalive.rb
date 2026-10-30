# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.1/agent-keepalive_0.4.1_darwin_arm64.tar.gz"
      sha256 "1d9c3248058f2237d4367b91236924ada83b8c08e5c869987e26908009ea9441"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.1/agent-keepalive_0.4.1_darwin_amd64.tar.gz"
      sha256 "a5f788461b8901afa55048060c967c2ff3f0746c5d50978785dcba8114058996"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.1/agent-keepalive_0.4.1_linux_arm64.tar.gz"
      sha256 "5c742266ccdf1c3a9bf0fd828eb33e5d319c2c793842753956fa3e43c36f50dd"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.1/agent-keepalive_0.4.1_linux_amd64.tar.gz"
      sha256 "9a1c559eb04caa5975e327b278aedecda278dff445472aae521ee2c3b00ce223"
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
