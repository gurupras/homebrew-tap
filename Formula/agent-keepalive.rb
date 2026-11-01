# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.4.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.4/agent-keepalive_0.4.4_darwin_arm64.tar.gz"
      sha256 "883228c7a47f693691c967e209b52e87e7ee5304c11b10994e26be6d71ba2663"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.4/agent-keepalive_0.4.4_darwin_amd64.tar.gz"
      sha256 "258d7bb0e3241fcbc9995d226e339d951f6e08db4dbd873c75305da3bf2b4c23"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.4/agent-keepalive_0.4.4_linux_arm64.tar.gz"
      sha256 "29f346915e2bd45e9fe4c157bc6b6063614d88d0414071c35271e3f3d83b3d59"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.4.4/agent-keepalive_0.4.4_linux_amd64.tar.gz"
      sha256 "459155dd756b5860e0af544f022646045b9cb9ae66d77a5afe00b0902cb613f7"
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
