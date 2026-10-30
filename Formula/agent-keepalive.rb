# Homebrew formula for agent-keepalive, rendered by packaging/homebrew/render-formula.sh
# from the release's archives and pushed to the tap by publish-tap.sh. Edit the
# template in the main repository, not the copy in the tap.
class AgentKeepalive < Formula
  desc "Keeps the prompt caches of chosen Claude Code and Codex sessions warm"
  homepage "https://agent-keepalive.gurupras.me"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.2/agent-keepalive_0.3.2_darwin_arm64.tar.gz"
      sha256 "a2864764046f2359f3c82bfd114444c35968bc565b7c215622a346192418e454"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.2/agent-keepalive_0.3.2_darwin_amd64.tar.gz"
      sha256 "a27e457e33cf799c1d63e698775cabfcc9657940440605c5960e8de99b7d2676"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.2/agent-keepalive_0.3.2_linux_arm64.tar.gz"
      sha256 "a2da929e8facc54069b762f77380cb2a94ee94b89c6fef4b340574d7036d5707"
    end
    on_intel do
      url "https://github.com/gurupras/agent-keepalive-manager/releases/download/v0.3.2/agent-keepalive_0.3.2_linux_amd64.tar.gz"
      sha256 "c7f991d1b6a2edb6bfa97280cac4725d609d48e5db35454dbf03406fd1ed8f76"
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
