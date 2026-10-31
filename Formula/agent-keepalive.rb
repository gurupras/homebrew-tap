# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.2/agent-keepalive_0.4.2_darwin_arm64.tar.gz"
      sha256 "ab153169c24261729fcbf332525e7285fa96ec64773d9fb1e47626113fd5c96e"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.2/agent-keepalive_0.4.2_darwin_amd64.tar.gz"
      sha256 "3209aeb7a42b71bc29694a69ddf295d23633d60dc2e8520dde89a128cdcbdbe0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.2/agent-keepalive_0.4.2_linux_arm64.tar.gz"
      sha256 "946a680d750be52773e162caff058f46e7a08af437609bb66c8cd49c7d5afd7d"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.2/agent-keepalive_0.4.2_linux_amd64.tar.gz"
      sha256 "e9fc4a2cc00dc7f93da03bc1412fd060758308ad44ba69dd3ea4cc02fb443bc0"
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
